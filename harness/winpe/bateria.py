#!/usr/bin/env python3
# =========================
# BATERIA WINPE — ETAPAS 1 A 3
# =========================
# 1. Triagem pelo catálogo (sem tocar em binário)
# 2. Empacotamento: identifica e extrai instaladores e arquivos compactados
# 3. Análise estática dos PEs extraídos (arquitetura, .NET, DLLs importadas)
#
# Nada é executado: só leitura e extração.
# Resultado em manifest/bateria_winpe.json, indexado pelo id do catálogo.
# A etapa 4 (smoke test em QEMU) depende da ISO do WinPE e fica para depois.
#
# Uso:
#   python3 harness/winpe/bateria.py --ferramentas "/caminho/FERRAMENTAS"
#   (ou variável BP_FERRAMENTAS; padrão: ../FERRAMENTAS ao lado do repositório)
#
# Dependências: python3-pefile, 7zip, innoextract, msitools

import argparse
import hashlib
import json
import mmap
import os
import re
import shutil
import subprocess
import sys
import tarfile
from datetime import date
from pathlib import Path

try:
    import pefile
except ImportError:
    sys.exit("[ERRO] pefile não encontrado. Instale com: sudo apt install python3-pefile")

ROOT = Path(__file__).resolve().parents[2]
CATALOGO = ROOT / "manifest" / "catalogo_manual.json"
SAIDA = ROOT / "manifest" / "bateria_winpe.json"

# Componentes que o WinPE aceita por injeção (WinPE-*)
INJETAVEIS = {"dotnet", "powershell", "wmi"}
# Runtimes que podem ir portáteis na partição de dados
RUNTIMES = {"python", "java"}

LIMITE_PE_POR_ITEM = 400
LIMITE_PROFUNDIDADE = 2
TIMEOUT = 900

MAQUINAS = {0x14C: "i386", 0x8664: "amd64", 0xAA64: "arm64"}
SUBSISTEMAS = {1: "native", 2: "gui", 3: "console"}

# Tipos que o 7z reconhece como contêiner extraível dentro de um PE
TIPOS_CONTEINER_7Z = {"Nsis", "7z", "Rar", "Rar5", "Cab", "Zip", "Xz", "Gzip", "Tar", "Wim", "Iso"}


# -------------------------
# Utilidades
# -------------------------
def rodar(cmd):
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, errors="replace", timeout=TIMEOUT)
        return r.returncode, r.stdout + r.stderr
    except subprocess.TimeoutExpired:
        return -1, "timeout"


def sha256(caminho):
    h = hashlib.sha256()
    with open(caminho, "rb") as f:
        for bloco in iter(lambda: f.read(1 << 20), b""):
            h.update(bloco)
    return h.hexdigest().upper()


def magia(caminho, n=8):
    with open(caminho, "rb") as f:
        return f.read(n)


def tipos_7z(caminho):
    """Tipos de arquivo que o 7z enxerga no cabeçalho (antes da lista de entradas)."""
    cod, saida = rodar([SETE_ZIP, "l", "-slt", str(caminho)])
    if cod != 0:
        return set()
    cabecalho = saida.split("----------", 1)[0]
    return set(re.findall(r"^Type = (\S+)", cabecalho, re.M))


def versao_inno(caminho):
    """Versão do formato de dados do Inno Setup, pela assinatura embutida no instalador."""
    with open(caminho, "rb") as f, mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as m:
        achado = re.search(rb"Inno Setup Setup Data \(([\d.]+)", m)
        return bytes(achado.group(1)).decode() if achado else None


def eh_instalador_disfarcado(caminho):
    """install4j, ou PE cuja carga (overlay ou .rsrc) é a maior parte do arquivo.

    Exceção: app .NET single-file também carrega o runtime no overlay, mas é portátil.
    """
    with open(caminho, "rb") as f, mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as m:
        if any(m.find(marca) != -1 for marca in MARCAS_BUNDLE_DOTNET):
            return False
        if m.find(b"install4j") != -1:
            return True
    try:
        pe = pefile.PE(str(caminho), fast_load=True)
    except pefile.PEFormatError:
        return True  # MZ que não é PE válido: stub de SFX
    tamanho = caminho.stat().st_size
    inicio = pe.get_overlay_data_start_offset()
    rsrc = sum(sec.SizeOfRawData for sec in pe.sections if sec.Name.rstrip(b"\0") == b".rsrc")
    pe.close()
    if tamanho < 5 * 1048576:
        return False
    carga = max(tamanho - inicio if inicio is not None else 0, rsrc)
    return carga / tamanho > 0.5


def eh_inno(caminho):
    cod, _ = rodar(["innoextract", "--info", "--silent", str(caminho)])
    return cod == 0


# -------------------------
# Etapa 1 — Triagem
# -------------------------
def triar(item):
    sistema = set(item["sistema"])
    if "recurso" in sistema:
        return "descartado", "recurso (documentação/wordlist, não executa)"
    if "bootavel" in sistema:
        return "descartado", "ambiente bootável (vai para a biblioteca do Ventoy)"
    if not sistema & {"windows", "ambos"}:
        return "descartado", "só Linux"
    if not item["arquivo"]:
        return "pendente", "sem binário em FERRAMENTAS"
    return "candidato", ""


# -------------------------
# Etapa 2 — Empacotamento
# -------------------------
def classificar(caminho):
    """Identifica como o artefato está empacotado, pelo conteúdo e não pela extensão."""
    if caminho.is_dir():
        return "pasta"
    cab = magia(caminho)
    if cab.startswith(b"PK\x03\x04"):
        return "zip"
    if cab.startswith(b"7z\xbc\xaf\x27\x1c"):
        return "7z"
    if cab.startswith(b"\x1f\x8b"):
        return "tar_gz"
    if cab.startswith(b"\xd0\xcf\x11\xe0"):
        return "msi"
    if cab.startswith(b"\x7fELF"):
        return "elf"
    if not cab.startswith(b"MZ"):
        return "desconhecido"

    nome = caminho.name.lower()
    if eh_inno(caminho):
        return "inno"
    if versao_inno(caminho):
        return "inno_nao_suportado"
    tipos = tipos_7z(caminho)
    if "Nsis" in tipos:
        return "nsis"
    if tipos & (TIPOS_CONTEINER_7Z - {"Nsis"}):
        return "sfx"
    if "online" in nome:
        return "instalador_online"
    if re.search(r"setup|install", nome) or eh_instalador_disfarcado(caminho):
        return "instalador_opaco"
    return "executavel"


EXTRAIVEIS = {"zip", "7z", "tar_gz", "msi", "inno", "nsis", "sfx"}


def extrair(caminho, tipo, destino):
    destino.mkdir(parents=True, exist_ok=True)
    if tipo in {"zip", "7z", "nsis", "sfx"}:
        cod, saida = rodar([SETE_ZIP, "x", "-y", f"-o{destino}", str(caminho)])
    elif tipo == "inno":
        cod, saida = rodar(["innoextract", "--silent", "--extract", "-d", str(destino), str(caminho)])
    elif tipo == "msi":
        cod, saida = rodar(["msiextract", "-C", str(destino), str(caminho)])
    elif tipo == "tar_gz":
        try:
            with tarfile.open(caminho) as t:
                t.extractall(destino, filter="data")
            cod, saida = 0, ""
        except (tarfile.TarError, OSError) as e:
            cod, saida = 1, str(e)
    else:
        return False, f"tipo não extraível: {tipo}"
    if cod == 0:
        return True, ""
    linhas = [l for l in saida.strip().splitlines() if l.startswith("ERROR")] or saida.strip().splitlines()
    erro = linhas[0] if linhas else f"código {cod}"
    # 7z devolve erro mesmo quando só alguns arquivos falham; o resto continua útil
    if any(destino.rglob("*")):
        return "parcial", erro
    return False, erro


def extrair_recursivo(raiz, profundidade, log):
    """Abre instaladores e compactados aninhados (ex.: zip com setup dentro)."""
    if profundidade >= LIMITE_PROFUNDIDADE:
        return
    for arq in sorted(raiz.rglob("*")):
        if not arq.is_file() or arq.suffix.lower() not in {".exe", ".msi", ".zip", ".7z"}:
            continue
        tipo = classificar(arq)
        if tipo not in EXTRAIVEIS:
            continue
        destino = arq.with_name(arq.name + ".extraido")
        if destino.exists():
            continue
        ok, erro = extrair(arq, tipo, destino)
        log.append({"aninhado": str(arq.relative_to(raiz)), "empacotamento": tipo, "extraido": ok, **({"erro": erro} if erro else {})})
        if ok:
            extrair_recursivo(destino, profundidade + 1, log)


def preparar(item, ferramentas, cache, limite_bytes):
    """Devolve (lista de arquivos com metadados, lista de raízes para analisar)."""
    arquivos, raizes = [], []
    for nome in item["arquivo"]:
        origem = ferramentas / nome
        registro = {"arquivo": nome}
        if not origem.exists():
            registro["empacotamento"] = "nao_encontrado"
            arquivos.append(registro)
            continue

        tipo = classificar(origem)
        registro["empacotamento"] = tipo
        if tipo.startswith("inno"):
            registro["inno"] = versao_inno(origem)
        if origem.is_file():
            registro["tamanho_mb"] = round(origem.stat().st_size / 1048576, 1)
            registro["sha256"] = sha256(origem)

        if tipo == "pasta":
            raizes.append(origem)
        elif tipo == "executavel":
            raizes.append(origem)
        elif tipo in EXTRAIVEIS:
            if origem.stat().st_size > limite_bytes:
                registro["extraido"] = False
                registro["erro"] = "acima do limite de extração"
            else:
                destino = cache / item["id"] / nome
                marca = destino / ".bateria_ok"
                if marca.exists():
                    erro_salvo = destino / ".bateria_erro"
                    registro["extraido"] = "parcial" if erro_salvo.exists() else True
                    if erro_salvo.exists():
                        registro["erro"] = erro_salvo.read_text()
                else:
                    if destino.exists():
                        shutil.rmtree(destino)
                    ok, erro = extrair(origem, tipo, destino)
                    registro["extraido"] = ok
                    if erro:
                        registro["erro"] = erro
                        (destino / ".bateria_erro").write_text(erro) if destino.exists() else None
                    if ok:
                        aninhados = []
                        extrair_recursivo(destino, 1, aninhados)
                        (destino / ".bateria_aninhados.json").write_text(json.dumps(aninhados, ensure_ascii=False))
                        marca.touch()
                if registro["extraido"]:
                    log = destino / ".bateria_aninhados.json"
                    if log.exists():
                        aninhados = json.loads(log.read_text())
                        if aninhados:
                            registro["aninhados"] = aninhados
                    raizes.append(destino)
        if tipo in {"zip", "7z"} and re.search(r"Data Error|CRC", registro.get("erro", "")):
            registro["integridade"] = "corrompido"
        arquivos.append(registro)
    return arquivos, raizes


# -------------------------
# Etapa 3 — Análise estática
# -------------------------
# Apphost de .NET single-file (a string aparece em ASCII ou UTF-16 conforme a versão)
_MARCA = "hostfxr_main_bundle_startupinfo"
MARCAS_BUNDLE_DOTNET = (_MARCA.encode(), _MARCA.encode("utf-16-le"))
PADRAO_WMI = re.compile(rb"root\\cimv2|r\x00o\x00o\x00t\x00\\\x00c\x00i\x00m\x00v\x002\x00", re.I)


def analisar_pe(caminho):
    try:
        pe = pefile.PE(str(caminho), fast_load=True)
    except (pefile.PEFormatError, OSError):
        return None
    pe.parse_data_directories(directories=[
        pefile.DIRECTORY_ENTRY["IMAGE_DIRECTORY_ENTRY_IMPORT"],
        pefile.DIRECTORY_ENTRY["IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT"],
    ])
    com = pe.OPTIONAL_HEADER.DATA_DIRECTORY[pefile.DIRECTORY_ENTRY["IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR"]]
    imports = set()
    for attr in ("DIRECTORY_ENTRY_IMPORT", "DIRECTORY_ENTRY_DELAY_IMPORT"):
        for entrada in getattr(pe, attr, []):
            imports.add(entrada.dll.decode(errors="replace").lower())
    dados = pe.__data__
    info = {
        "arquitetura": MAQUINAS.get(pe.FILE_HEADER.Machine, hex(pe.FILE_HEADER.Machine)),
        "subsistema": SUBSISTEMAS.get(pe.OPTIONAL_HEADER.Subsystem, str(pe.OPTIONAL_HEADER.Subsystem)),
        "dotnet": com.VirtualAddress != 0 or "mscoree.dll" in imports,
        "wmi": bool(PADRAO_WMI.search(dados)),
        "bundle_dotnet": any(dados.find(marca) != -1 for marca in MARCAS_BUNDLE_DOTNET),
        "imports": imports,
    }
    pe.close()
    return info


# Partes de caminho que são maquinário do instalador, não da ferramenta
INFRA_DIRS = re.compile(r"^(\$PLUGINSDIR|\$_\d+_|tmp)$", re.I)
INFRA_NOMES = re.compile(r"^(uninst|unins\d+|vc_?redist|vcredist|setup|install)", re.I)


VARIANTE_64 = re.compile(r"(^|[/_\-.])(x64|amd64|win64|64bit|altexe)([/_\-.]|$)", re.I)


def eh_infra(rel):
    partes = Path(rel).parts
    return any(INFRA_DIRS.match(p) for p in partes[:-1]) or bool(INFRA_NOMES.match(partes[-1]))


def analisar(raizes):
    """Lê todos os PEs; o veredito sai só dos executáveis principais.

    Principal = .exe fora da infraestrutura do instalador, na menor profundidade
    em que existe algum. Os demais viram auxiliares e só geram notas.
    """
    pes, extras = [], {}
    for raiz in raizes:
        candidatos = [raiz] if raiz.is_file() else sorted(p for p in raiz.rglob("*") if p.is_file())
        for arq in candidatos:
            ext = arq.suffix.lower()
            rel = arq.name if arq == raiz else str(arq.relative_to(raiz))
            if ext in {".ps1", ".py", ".jar"}:
                if not eh_infra(rel):
                    # Guarda a profundidade mais rasa de cada tipo de script
                    prof = len(Path(rel).parts)
                    extras[ext[1:]] = min(extras.get(ext[1:], prof), prof)
            elif ext in {".exe", ".dll", ".sys"} or arq == raiz:
                if magia(arq, 2) == b"MZ":
                    pes.append((rel, arq))

    truncado = len(pes) > LIMITE_PE_POR_ITEM
    locais = {arq.name.lower() for _, arq in pes}
    analisados = []
    for rel, arq in pes[:LIMITE_PE_POR_ITEM]:
        info = analisar_pe(arq)
        if info:
            info["rel"] = rel
            # Instalador aninhado já extraído: quem conta é o conteúdo, não ele
            info["infra"] = eh_infra(rel) or arq.with_name(arq.name + ".extraido").is_dir()
            info["tipo"] = arq.suffix.lower() or ".exe"
            analisados.append(info)

    exes = [i for i in analisados if i["tipo"] != ".dll" and i["tipo"] != ".sys" and not i["infra"]]
    if exes:
        rasa = min(len(Path(i["rel"]).parts) for i in exes)
        for i in exes:
            i["principal"] = len(Path(i["rel"]).parts) == rasa

    uteis = [i for i in analisados if not i["infra"]]
    dlls_externas = set()
    for i in uteis:
        dlls_externas |= {d for d in i["imports"] if d not in locais and not d.startswith(("api-ms-win-", "ext-ms-"))}

    return analisados, exes, sorted(dlls_externas), extras, truncado


def veredito(arquivos, analisados, exes, extras):
    needs, notas = set(), []
    principais = [e for e in exes if e.get("principal")]
    auxiliares = [e for e in exes if not e.get("principal")]

    # Com variante 64 bits disponível, a de 32 bits não conta
    arqs = {e["arquitetura"] for e in principais}
    # Só vale como variante 64 bits o que se anuncia assim (x64/, altexe/, *_X64.exe),
    # não qualquer exe 64 bits embutido (ex.: python.exe do Zenmap, java.exe de um JRE)
    em_subpasta = [e for e in auxiliares if e["arquitetura"] == "amd64" and VARIANTE_64.search(e["rel"])]
    if "amd64" in arqs:
        base = [e for e in principais if e["arquitetura"] == "amd64"]
        if "i386" in arqs:
            notas.append("pacote traz variantes 32 e 64 bits; usar a de 64")
    elif "i386" in arqs and em_subpasta:
        # Ex.: x96dbg.exe (lançador 32 bits) na raiz, x64/x64dbg.exe na subpasta
        base = em_subpasta
        notas.append("principal da raiz é 32 bits, mas há executáveis 64 bits em subpasta: "
                     + ", ".join(e["rel"] for e in em_subpasta[:3]))
    else:
        base = principais
        if "i386" in arqs:
            needs.add("wow64")
            notas.append("executável principal só em 32 bits; WinPE amd64 não traz WoW64")

    if any(e["dotnet"] for e in base):
        needs.add("dotnet")
    if any(e["bundle_dotnet"] for e in base):
        notas.append(".NET single-file autocontido: não usa WinPE-NetFx, validar no smoke test")
    if any(e["wmi"] for e in base):
        needs.add("wmi")
        notas.append("wmi é heurística (string root\\cimv2 no binário)")

    drivers = [i["rel"] for i in analisados if i["tipo"] == ".sys" or i["subsistema"] == "native"]
    if any(not eh_infra(d) for d in drivers):
        needs.add("kernel-driver")
    elif drivers:
        notas.append(f"instalador embute driver de kernel ({len(drivers)} arquivo(s)), ex.: {drivers[0]}")

    aux_dotnet = [Path(e["rel"]).name for e in auxiliares if e["dotnet"]]
    if aux_dotnet:
        notas.append("auxiliares .NET (não bloqueiam a ferramenta): " + ", ".join(aux_dotnet[:5]))

    # Script conta quando está mais perto da raiz que o executável mais raso:
    # Ghidra (jar em support/, exes nativos fundo) precisa de Java; VLC (jar em plugins/) não
    raso = min((len(Path(e["rel"]).parts) for e in principais), default=float("inf"))
    if "ps1" in extras and extras["ps1"] < raso:
        needs.add("powershell")
    if "py" in extras and extras["py"] < raso:
        needs.add("python")
    if "jar" in extras and extras["jar"] < raso and not any(Path(i["rel"]).name.lower() in {"java.exe", "javaw.exe"} for i in analisados):
        needs.add("java")

    tipos = {a.get("empacotamento") for a in arquivos}
    # Sem executável, só scripts (PowerShell, Python, Java) ainda contam como analisáveis
    corrompidos = [a["arquivo"] for a in arquivos if a.get("integridade") == "corrompido"]
    if corrompidos:
        notas.append("arquivo corrompido (CRC), baixar de novo: " + ", ".join(corrompidos))
    if not principais and not needs & (RUNTIMES | {"powershell"}):
        falhas = [f'{a["arquivo"]}: {a["erro"]}' for a in arquivos if a.get("erro")]
        if falhas:
            return "bloqueado", sorted(needs), notas + falhas
        if "inno_nao_suportado" in tipos:
            versoes = sorted({a["inno"] for a in arquivos if a.get("inno")})
            return "bloqueado", sorted(needs), notas + [f"Inno Setup {', '.join(versoes)} não suportado pelo innoextract instalado"]
        if "instalador_online" in tipos:
            return "bloqueado", sorted(needs), notas + ["só existe instalador online"]
        if "instalador_opaco" in tipos:
            return "bloqueado", sorted(needs), notas + ["instalador não extraível estaticamente"]
        return "sem_pe_analisavel", sorted(needs), notas

    if "wow64" in needs:
        return "provavel_nao_roda", sorted(needs), notas
    if needs & RUNTIMES:
        return "precisa_runtime", sorted(needs), notas
    if "kernel-driver" in needs:
        return "incerto", sorted(needs), notas + ["driver de kernel: carregar com drvload no smoke test"]
    if needs:
        return "provavel_com_componente", sorted(needs), notas
    return "provavel_base", [], notas


# -------------------------
# Execução
# -------------------------
def main():
    global SETE_ZIP
    ap = argparse.ArgumentParser(description="Bateria WinPE — etapas 1 a 3")
    ap.add_argument("--ferramentas", default=os.environ.get("BP_FERRAMENTAS", str(ROOT.parent / "FERRAMENTAS")))
    ap.add_argument("--cache", default=os.environ.get("BP_CACHE"))
    ap.add_argument("--limite-mb", type=int, default=int(os.environ.get("BP_LIMITE_MB", "1500")))
    ap.add_argument("--somente", nargs="*", help="ids específicos do catálogo")
    args = ap.parse_args()

    ferramentas = Path(args.ferramentas)
    if not ferramentas.is_dir():
        sys.exit(f"[ERRO] Pasta de ferramentas não encontrada: {ferramentas}")
    cache = Path(args.cache) if args.cache else ferramentas.parent / ".bateria_cache"

    SETE_ZIP = shutil.which("7z") or shutil.which("7zz")
    faltando = [n for n, ok in (("7z", SETE_ZIP), ("innoextract", shutil.which("innoextract")), ("msiextract", shutil.which("msiextract"))) if not ok]
    if faltando:
        sys.exit(f"[ERRO] Dependências ausentes: {', '.join(faltando)}")

    catalogo = json.loads(CATALOGO.read_text(encoding="utf-8"))["ferramentas"]
    anterior = json.loads(SAIDA.read_text(encoding="utf-8"))["itens"] if SAIDA.exists() else {}
    itens = dict(anterior) if args.somente else {}

    print(f"Ferramentas: {ferramentas}")
    print(f"Cache de extração: {cache}\n")

    for item in catalogo:
        if args.somente and item["id"] not in args.somente:
            continue
        status, motivo = triar(item)
        registro = {"nome": item["nome"], "triagem": status}
        if motivo:
            registro["motivo"] = motivo

        if status == "candidato":
            print(f"  ~ {item['id']}", flush=True)
            arquivos, raizes = preparar(item, ferramentas, cache, args.limite_mb * 1048576)
            analisados, exes, dlls, extras, truncado = analisar(raizes)
            v, needs, notas = veredito(arquivos, analisados, exes, extras)
            exes = sorted(exes, key=lambda e: not e.get("principal"))
            exes = [{"exe": e["rel"], "arquitetura": e["arquitetura"], "subsistema": e["subsistema"],
                     "dotnet": e["dotnet"], "principal": e.get("principal", False)} for e in exes]
            registro.update({
                "arquivos": arquivos,
                "executaveis": exes[:50],
                "dlls_externas": dlls,
                "needs_estaticos": needs,
                "veredito_estatico": v,
            })
            if len(exes) > 50:
                registro["executaveis_total"] = len(exes)
            if truncado:
                notas.append(f"análise limitada a {LIMITE_PE_POR_ITEM} PEs")
            if notas:
                registro["notas"] = notas
            print(f"    -> {v} {needs if needs else ''}")
        itens[item["id"]] = registro

    saida = {
        "gerado_em": date.today().isoformat(),
        "etapas": "1-3 (triagem, empacotamento, análise estática)",
        "itens": itens,
    }
    SAIDA.write_text(json.dumps(saida, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    contagem = {}
    for r in itens.values():
        chave = r.get("veredito_estatico", r["triagem"])
        contagem[chave] = contagem.get(chave, 0) + 1
    print("\nResumo:")
    for chave, n in sorted(contagem.items(), key=lambda x: -x[1]):
        print(f"  {chave:26} {n}")
    print(f"\nSalvo em: {SAIDA}")


if __name__ == "__main__":
    main()
