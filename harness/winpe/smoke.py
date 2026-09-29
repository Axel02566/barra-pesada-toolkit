#!/usr/bin/env python3
# =========================
# BATERIA WINPE — ETAPA 4 (SMOKE TEST EM QEMU)
# =========================
# 1. Escolhe o que testar a partir de manifest/bateria_winpe.json
# 2. Monta uma imagem FAT32 com as ferramentas extraídas + smoke.ps1
# 3. Boota a ISO do WinPE no QEMU (UEFI); o startnet.cmd da receita
#    acha \BP_SMOKE\smoke.cmd, roda os testes e desliga a VM
# 4. Lê os resultados da imagem e grava em bateria_winpe.json (campo "smoke")
#
# Tudo sem root: imagem criada com mkfs.fat + mtools, VM com KVM do usuário.
# A pasta \BP_SMOKE\ é reservada: não usar esse nome na partição de dados real,
# senão o WinPE roda os testes e desliga ao bootar.
#
# Uso:
#   python3 harness/winpe/smoke.py --iso ".../barra-pesada-winpe.iso" \
#       --ferramentas ".../FERRAMENTAS"
#
# Dependências: qemu-system-x86, ovmf, mtools, dosfstools

import argparse
import json
import os
import shutil
import socket
import subprocess
import sys
import tempfile
import threading
import time
from datetime import date, datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from bateria import EXTRAIVEIS, INJETAVEIS, SAIDA, VARIANTE_64  # noqa: E402

AQUI = Path(__file__).resolve().parent
TESTAVEIS = {"provavel_base", "provavel_com_componente", "provavel_nao_roda", "incerto"}

OVMF = [
    ("/usr/share/OVMF/OVMF_CODE_4M.fd", "/usr/share/OVMF/OVMF_VARS_4M.fd"),
    ("/usr/share/OVMF/OVMF_CODE.fd", "/usr/share/OVMF/OVMF_VARS.fd"),
    ("/usr/share/edk2/x64/OVMF_CODE.4m.fd", "/usr/share/edk2/x64/OVMF_VARS.4m.fd"),
    ("/usr/share/edk2/ovmf/OVMF_CODE.fd", "/usr/share/edk2/ovmf/OVMF_VARS.fd"),
]

# Resultados do runner que contam como "rodou"
OK = {"janela_aberta", "em_execucao"}

SMOKE_CMD = "\r\n".join([
    "@echo off",
    "set BP=%1\\BP_SMOKE",
    "if not exist %BP%\\resultados mkdir %BP%\\resultados",
    "powershell -NoProfile -ExecutionPolicy Bypass -File %BP%\\smoke.ps1 -Raiz %BP% > %BP%\\resultados\\console.log 2>&1",
    "wpeutil shutdown",
    "",
])


# -------------------------
# Seleção dos testes
# -------------------------
def escolher_exes(reg, maximo):
    """Mesma regra do veredito estático: 64 bits se houver, senão os de 32 para confirmar o WoW64."""
    exes = reg.get("executaveis", [])
    principais = [e for e in exes if e.get("principal")]
    escolhidos = [e for e in principais if e["arquitetura"] == "amd64"]
    if not escolhidos:
        escolhidos = [e for e in exes if not e.get("principal") and e["arquitetura"] == "amd64"
                      and VARIANTE_64.search(e["exe"])]
    if not escolhidos:
        escolhidos = [e for e in principais if e["arquitetura"] == "i386"]
    return escolhidos[:maximo]


def raizes(item_id, reg, ferramentas, cache):
    """Onde cada artefato do item está no Linux (extraído no cache ou original)."""
    saida = []
    for a in reg.get("arquivos", []):
        tipo, nome = a.get("empacotamento"), a["arquivo"]
        if tipo in EXTRAIVEIS and a.get("extraido"):
            saida.append(cache / item_id / nome)
        elif tipo in {"executavel", "pasta"}:
            saida.append(ferramentas / nome)
    return saida


def localizar(rel, candidatas):
    for n, r in enumerate(candidatas):
        if (r.is_file() and r.name == rel) or (r.is_dir() and (r / rel).is_file()):
            return n
    return None


def planejar(itens, ferramentas, cache, maximo, somente):
    testes, copias = [], {}
    for item_id, reg in itens.items():
        if somente and item_id not in somente:
            continue
        if reg.get("veredito_estatico") not in TESTAVEIS:
            continue
        candidatas = raizes(item_id, reg, ferramentas, cache)
        for e in escolher_exes(reg, maximo):
            n = localizar(e["exe"], candidatas)
            if n is None:
                print(f"  [aviso] {item_id}: {e['exe']} não encontrado no cache")
                continue
            copias[(item_id, n)] = candidatas[n]
            rel = candidatas[n].name if candidatas[n].is_file() else e["exe"]
            testes.append((item_id, n, rel.replace("/", "\\"), e["arquitetura"], e["subsistema"]))
    return testes, copias


# -------------------------
# Imagem de dados (FAT32, sem root)
# -------------------------
def tamanho(caminho):
    if caminho.is_file():
        return caminho.stat().st_size
    return sum(p.stat().st_size for p in caminho.rglob("*") if p.is_file())


def mtools(*args):
    env = dict(os.environ, MTOOLS_SKIP_CHECK="1")
    r = subprocess.run(list(args), capture_output=True, text=True, env=env)
    if r.returncode != 0:
        raise RuntimeError(f"{args[0]} falhou: {r.stderr.strip() or r.stdout.strip()}")


def montar_imagem(img, testes, copias, espera, temp):
    bruto = sum(tamanho(c) for c in copias.values())
    total = int(bruto * 1.15) + 512 * 1048576
    print(f"Imagem de dados: {total / 1073741824:.1f} GB ({len(copias)} pacotes, {len(testes)} testes)")

    img.unlink(missing_ok=True)
    with open(img, "wb") as f:
        f.truncate(total)
    r = subprocess.run(["mkfs.fat", "-F", "32", "-n", "BPSMOKE", str(img)], capture_output=True, text=True)
    if r.returncode != 0:
        raise RuntimeError(f"mkfs.fat falhou: {r.stderr.strip()}")

    i = ["-i", str(img)]
    criadas = set()

    def mmd(caminho):
        if caminho not in criadas:
            mtools("mmd", *i, f"::{caminho}")
            criadas.add(caminho)

    for pasta in ("BP_SMOKE", "BP_SMOKE/f", "BP_SMOKE/resultados"):
        mmd(pasta)

    # Arquivos de controle
    (temp / "smoke.cmd").write_bytes(SMOKE_CMD.encode("ascii"))
    (temp / "config.json").write_text(json.dumps({"espera_segundos": espera}), encoding="utf-8")
    (temp / "testes.tsv").write_text("\r\n".join("\t".join(map(str, t)) for t in testes) + "\r\n", encoding="utf-8")
    (temp / "vazio.txt").write_bytes(b"")
    shutil.copy(AQUI / "smoke.ps1", temp / "smoke.ps1")
    for nome in ("smoke.cmd", "smoke.ps1", "config.json", "testes.tsv", "vazio.txt"):
        mtools("mcopy", *i, str(temp / nome), "::BP_SMOKE/")

    # Pacotes: cada raiz vira \BP_SMOKE\f\<id>\<n>\ (caminho curto por causa do MAX_PATH)
    for (item_id, n), origem in sorted(copias.items()):
        print(f"  + {item_id}/{n}", flush=True)
        mmd(f"BP_SMOKE/f/{item_id}")
        mmd(f"BP_SMOKE/f/{item_id}/{n}")
        destino = f"::BP_SMOKE/f/{item_id}/{n}/"
        if origem.is_file():
            mtools("mcopy", *i, str(origem), destino)
        else:
            entradas = [str(p) for p in sorted(origem.iterdir()) if not p.name.startswith(".bateria")]
            if entradas:
                mtools("mcopy", "-s", "-n", "-D", "o", *i, *entradas, destino)


# -------------------------
# VM
# -------------------------
def monitor(sock, comando):
    try:
        with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
            s.settimeout(3)
            s.connect(str(sock))
            s.sendall((comando + "\n").encode())
            time.sleep(0.2)
    except OSError:
        pass


def apertar_teclas(sock, parar, segundos=40):
    """O boot da ISO pede 'Press any key to boot from CD or DVD'."""
    for _ in range(segundos):
        if parar.is_set():
            return
        monitor(sock, "sendkey ret")
        time.sleep(1)


def rodar_vm(iso, img, memoria, limite, temp, log_dir):
    qemu = shutil.which("qemu-system-x86_64")
    ovmf = next(((c, v) for c, v in OVMF if Path(c).exists() and Path(v).exists()), None)
    if not ovmf:
        raise RuntimeError("OVMF não encontrado (instale o pacote ovmf)")
    vars_copia = temp / "OVMF_VARS.fd"
    shutil.copy(ovmf[1], vars_copia)
    sock = temp / "monitor.sock"

    def esc(p):  # vírgula é separador de opção no -drive
        return str(p).replace(",", ",,")

    cmd = [
        qemu, "-enable-kvm", "-machine", "q35", "-cpu", "host", "-smp", "2", "-m", str(memoria),
        "-drive", f"if=pflash,format=raw,readonly=on,file={esc(ovmf[0])}",
        "-drive", f"if=pflash,format=raw,file={esc(vars_copia)}",
        "-drive", f"file={esc(iso)},media=cdrom,readonly=on",
        "-drive", f"file={esc(img)},format=raw",
        "-boot", "order=d", "-vga", "std", "-display", "none", "-net", "none", "-no-reboot",
        "-monitor", f"unix:{sock},server,nowait",
    ]
    print(f"\nBootando WinPE (limite de {limite // 60} min)...")
    inicio = time.time()
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
    parar = threading.Event()
    threading.Thread(target=apertar_teclas, args=(sock, parar), daemon=True).start()
    try:
        proc.wait(timeout=limite)
        estourou = False
    except subprocess.TimeoutExpired:
        estourou = True
        # O monitor não aceita espaço no caminho: grava no temp e copia depois
        tela = temp / "tela.ppm"
        monitor(sock, f"screendump {tela}")
        time.sleep(1)
        if tela.exists():
            shutil.copy(tela, log_dir / "tela_no_limite.ppm")
        monitor(sock, "quit")
        proc.wait(timeout=30)
    parar.set()
    saida = proc.stdout.read() if proc.stdout else ""
    if saida.strip():
        (log_dir / "qemu.log").write_text(saida)
    print(f"VM encerrada em {(time.time() - inicio) / 60:.1f} min" + (" (LIMITE ESTOURADO)" if estourou else ""))
    return estourou


# -------------------------
# Resultados
# -------------------------
def ler_jsonl(caminho):
    if not caminho.exists():
        return []
    linhas = caminho.read_text(encoding="utf-8-sig").splitlines()
    return [json.loads(l.lstrip("﻿")) for l in linhas if l.strip()]


def classificar(t):
    r = t.get("resultado")
    if r in OK:
        return "ok"
    if r == "encerrou":
        # Console sem argumentos costuma sair na hora com uso/erro: rodou.
        # GUI que fecha sozinha com código diferente de 0 é suspeita.
        return "ok" if t.get("subsistema") != "gui" or t.get("codigo") == 0 else "duvidoso"
    return "falha"


def veredito_smoke(reg, testes):
    classes = {classificar(t) for t in testes}
    if "ok" in classes:
        return "roda_com_componente" if set(reg.get("needs_estaticos", [])) & INJETAVEIS else "roda_base"
    if "duvidoso" in classes:
        return "duvidoso"
    return "nao_roda"


def gravar(resultados, ambiente, completo):
    dados = json.loads(SAIDA.read_text(encoding="utf-8"))
    por_item = {}
    for t in resultados:
        por_item.setdefault(t["id"], []).append({k: v for k, v in t.items() if k not in {"id", "n"}})
    for item_id, testes in por_item.items():
        reg = dados["itens"][item_id]
        reg["smoke"] = {"data": date.today().isoformat(), "veredito": veredito_smoke(reg, testes), "testes": testes}
    dados["etapas"] = "1-4 (triagem, empacotamento, análise estática, smoke test)"
    dados["smoke_ambiente"] = dict(ambiente, execucao_completa=completo, data=date.today().isoformat())
    SAIDA.write_text(json.dumps(dados, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return dados, por_item


def main():
    ap = argparse.ArgumentParser(description="Bateria WinPE — etapa 4 (smoke test em QEMU)")
    ap.add_argument("--iso", required=True)
    ap.add_argument("--ferramentas", default=os.environ.get("BP_FERRAMENTAS"))
    ap.add_argument("--cache", default=os.environ.get("BP_CACHE"))
    ap.add_argument("--trabalho", help="onde ficam a imagem e os logs (padrão: .smoke ao lado do cache)")
    ap.add_argument("--memoria", type=int, default=4096, help="RAM da VM em MB")
    ap.add_argument("--espera", type=int, default=8, help="segundos por executável")
    ap.add_argument("--max-por-item", type=int, default=5)
    ap.add_argument("--limite-min", type=int, default=90, help="tempo máximo da VM")
    ap.add_argument("--somente", nargs="*", help="ids específicos do catálogo")
    ap.add_argument("--so-imagem", action="store_true", help="monta a imagem e para (sem bootar)")
    args = ap.parse_args()

    necessarios = ["mkfs.fat", "mcopy", "mmd"] + ([] if args.so_imagem else ["qemu-system-x86_64"])
    faltando = [n for n in necessarios if not shutil.which(n)]
    if faltando:
        sys.exit(f"[ERRO] Dependências ausentes: {', '.join(faltando)} (pacotes: qemu-system-x86, dosfstools, mtools)")
    if not args.ferramentas or not Path(args.ferramentas).is_dir():
        sys.exit("[ERRO] Informe --ferramentas (ou BP_FERRAMENTAS) com a pasta FERRAMENTAS montada")
    iso = Path(args.iso)
    if not args.so_imagem and not iso.is_file():
        sys.exit(f"[ERRO] ISO não encontrada: {iso}")
    if not SAIDA.exists():
        sys.exit("[ERRO] Rode bateria.py antes: manifest/bateria_winpe.json não existe")

    ferramentas = Path(args.ferramentas)
    cache = Path(args.cache) if args.cache else ferramentas.parent / ".bateria_cache"
    trabalho = Path(args.trabalho) if args.trabalho else cache.parent / ".smoke"
    trabalho.mkdir(parents=True, exist_ok=True)
    img = trabalho / "disco_smoke.img"
    log_dir = trabalho / f"resultados-{datetime.now():%Y%m%d-%H%M%S}"
    log_dir.mkdir()

    itens = json.loads(SAIDA.read_text(encoding="utf-8"))["itens"]
    testes, copias = planejar(itens, ferramentas, cache, args.max_por_item, args.somente)
    if not testes:
        sys.exit("Nada para testar.")

    with tempfile.TemporaryDirectory(prefix="bp_smoke_") as t:
        temp = Path(t)
        montar_imagem(img, testes, copias, args.espera, temp)
        if args.so_imagem:
            print(f"\nImagem pronta em: {img}")
            return
        estourou = rodar_vm(iso, img, args.memoria, args.limite_min * 60, temp, log_dir)

    mtools("mcopy", "-s", "-n", "-i", str(img), "::BP_SMOKE/resultados", str(log_dir))
    pasta = log_dir / "resultados"
    resultados = ler_jsonl(pasta / "resultados.jsonl")
    amb_arq = pasta / "ambiente.json"
    ambiente = json.loads(amb_arq.read_text(encoding="utf-8-sig")) if amb_arq.exists() else {}
    completo = (pasta / "fim.txt").exists() and not estourou

    if not resultados:
        print(f"\n[ERRO] Nenhum resultado. O WinPE rodou o smoke.cmd? Veja {log_dir}")
        print("  - sem inicio.txt: o gancho do startnet.cmd não achou \\BP_SMOKE\\smoke.cmd")
        print("  - tela_no_limite.ppm mostra onde a VM parou")
        sys.exit(1)

    _, por_item = gravar(resultados, ambiente, completo)

    print(f"\nAmbiente: WoW64={'sim' if ambiente.get('wow64') else 'não'}, "
          f"caixas de erro suprimidas={'sim' if ambiente.get('dialogos_supressos') else 'NÃO'}")
    if not completo:
        print("[AVISO] Execução incompleta: resultados parciais gravados.")
    contagem = {}
    dados = json.loads(SAIDA.read_text(encoding="utf-8"))["itens"]
    for item_id in por_item:
        v = dados[item_id]["smoke"]["veredito"]
        contagem[v] = contagem.get(v, 0) + 1
        print(f"  {item_id:28} {v}")
    print("\nResumo:")
    for v, n in sorted(contagem.items(), key=lambda x: -x[1]):
        print(f"  {v:22} {n}")
    print(f"\nLogs e capturas: {log_dir}")
    print(f"Salvo em: {SAIDA}")


if __name__ == "__main__":
    main()
