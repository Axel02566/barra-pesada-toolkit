# CHANGELOG

Registro de alterações do BARRA PESADA — Toolkit.

## [1.10] — Setembro/2026

### Adicionado
- Etapa 4 da bateria WinPE (smoke test), ainda não executada — depende da ISO gerada pela receita:
  - `harness/winpe/smoke.py` — lado Linux: escolhe os executáveis a testar a partir de `bateria_winpe.json`, monta uma imagem FAT32 sem root (`mkfs.fat` + `mtools`), boota o WinPE no QEMU em UEFI e grava o resultado de cada item no campo `smoke` do mesmo JSON.
  - `harness/winpe/smoke.ps1` — lado WinPE: registra o ambiente (inclusive se há WoW64), roda cada executável com as caixas de erro do Windows suprimidas, classifica o resultado (janela aberta, DLL ausente, formato inválido etc.) e tira captura de tela das ferramentas gráficas.
- `recipes/winpe/` — receita versionada do WinPE custom (`receita.json` + `construir_winpe.ps1` + `Construir_WinPE.bat`), com gancho `\BP_SMOKE\smoke.cmd` no `startnet.cmd`. Ainda não executada no Windows. Entrou no commit anterior à 1.9, junto com o `.gitignore` do projeto, e ficou sem registro aqui.

### Conhecido
- `\BP_SMOKE\` é nome reservado: se existir numa unidade quando o WinPE boota, ele roda os testes e desliga. Não usar esse nome na partição de dados real.
- WinUtil não tem executável e fica fora do smoke test.

---

## [1.9] — Setembro/2026

### Adicionado
- **Hardware / Benchmark** ganhou cobertura de teste de RAM fora do Windows:
  - Memtest86+ `[Bootável]` — testador de RAM open source (GPL), redundância livre para o MemTest86 na biblioteca do Ventoy.
  - memtester `[Linux]` — teste de RAM em espaço de usuário; par funcional do HCI MemTest do lado Linux.
- **Recuperação / Backup**: Sergei Strelec WinPE `[Bootável]` — WinPE de terceiros como ferramenta de prateleira, só do site oficial com checksum conferido; não serve de base para serviço cobrado.
- `indice_geral-v1.5.md` renomeado para `indice_geral-v1.6.md`; nova entrada em **Documentação por ferramenta** agrupando os testes de RAM por ambiente (sem SO, Linux vivo, Windows vivo).
- 3 novas entradas em `manifest/catalogo_manual.json` (118 → 121), no padrão das anteriores (`arquivo` vazio por não haver binário em `FERRAMENTAS/`, `sha256` do próprio `.md`, `tipo` vazio).
- `files_health/hashes_sha256.txt` regenerado — 97 → 100 documentos hasheados.

### Conhecido
- `manifest/bateria_winpe.json` ainda não inclui as 3 entradas novas; pela triagem, as três seriam descartadas da bateria (duas bootáveis, uma só Linux).

---

## [1.8] — Setembro/2026

### Adicionado
- `harness/winpe/bateria.py` — bateria de compatibilidade com WinPE, etapas 1 a 3 (triagem pelo catálogo, identificação e extração de empacotamento, análise estática de PE). Nada é executado; só leitura e extração. Primeiro script do projeto em Python, por depender do `pefile`; roda só do lado Linux.
- `manifest/bateria_winpe.json` — resultado da primeira rodada sobre as 118 entradas do catálogo, indexado pelo `id`: 19 prováveis no WinPE base, 10 com componente injetado, 10 prováveis não roda (só 32 bits), 5 precisam de runtime, 14 bloqueados, 2 incertos, 3 sem PE analisável, 15 pendentes e 39 descartados.

### Conhecido
- `ghidra_12.0.4_PUBLIC_20260303.zip` está corrompido (CRC do `jython-standalone-2.7.4.jar` não confere) — baixar de novo.
- HWiNFO, HWMonitor, CPU-Z, FurMark e Git usam Inno Setup 6.3+, que o `innoextract` 1.9 do Ubuntu não abre; Burp e ZAP são install4j. Trocar por versões portáteis.
- O catálogo marca MangoHud como `ambos`, mas é só Linux; `hashcat-7.1.2.tar.gz` é código-fonte, não binário Windows.

---

## [1.7] — Setembro/2026

### Adicionado
- Categoria **Reverse Engineering / Forensics** ganhou o tripé clássico de DFIR que faltava — registro e disco, complementando volatility3 (memória):
  - RegRipper `[Windows / Linux]` — análise forense de hives do Registro do Windows via plugins.
  - Hivex `[Linux]` — biblioteca de leitura/escrita de hives de registro, complemento de baixo nível ao RegRipper.
  - The Sleuth Kit (TSK) `[Windows / Linux]` — análise forense de imagem de disco e sistema de arquivos.
- `indice_geral-v1.4.md` renomeado para `indice_geral-v1.5.md`; nova entrada em **Documentação por ferramenta** ligando os três `.md` como o tripé registro/disco/memória.
- 3 novas entradas em `manifest/catalogo_manual.json` (115 → 118), seguindo o mesmo padrão das anteriores (`documentacao` casado com `Personal_Doc/`, `sha256` do próprio hash da documentação, `tipo` vazio por falta de linha `Tipo:` explícita nos docs).
- `files_health/hashes_sha256.txt` regenerado — 94 → 97 documentos hasheados.

---

## [1.6] — Agosto/2026

### Adicionado
- 16 novas ferramentas distribuídas em 4 categorias já existentes do Índice Geral (`indice_geral-v1.3.md` → `indice_geral-v1.4.md`):
  - **Rede / Infraestrutura**: Netcat (ncat), tcpdump, iperf3, mtr.
  - **Reverse Engineering / Forensics**: binwalk, WinDbg, crash (kdump-utils), Manuais de Arquitetura (Intel, AMD, ARM), Bug Check Code Reference (Windows), Kernel Panic e Oops (Linux).
  - **Segurança / Pentest**: ParamSpider, ffuf, SQLMap, subfinder.
  - **Virtualização / Ambientes**: QEMU, Sandboxie-Plus.
- 16 novas entradas em `manifest/catalogo_manual.json` (99 → 115), preenchidas com o mesmo padrão da v1.5 do catálogo (`documentacao`, `sha256`, `aliases` grounded, `tipo` só onde há evidência explícita).
- `files_health/hashes_sha256.txt` regenerado — 78 → 94 documentos hasheados.
- SQLMap, ffuf, Netcat (ncat) e tcpdump adicionados à lista de **Ferramentas de risco elevado**.

### Conhecido
- Nenhum binário verificado para as 16 ferramentas novas em `FERRAMENTAS/` no momento desta atualização — `arquivo: []` em todas.

---

## [1.5] — Julho/2026

### Adicionado
- `arquivo`, `documentacao`, `sha256`, `aliases` e `tipo` preenchidos nas 99 entradas de `manifest/catalogo_manual.json` — débito aberto desde a criação do catálogo manual, que impedia o buscador de ligar ferramenta → documentação/arquivo.
  - `documentacao` casado com os arquivos de `Personal_Doc/`.
  - `sha256` preenchido com o hash do arquivo de documentação (fonte: `files_health/hashes_sha256.txt`).
  - `arquivo` preenchido com os binários reais em `FERRAMENTAS/` (campo passou a ser array — VeraCrypt e Dependency Walker têm mais de um arquivo por ferramenta).
  - `tipo` preenchido para as ferramentas com tipo explícito em `GUIA_DE_MONITORAMENTO.md`; `aliases` preenchido com abreviações e nomes alternativos conhecidos.
- Opção **6) Arquivo** em `buscador_manifesto.sh` e `buscar_manifesto.ps1` — busca por nome de arquivo, agora que o campo está preenchido.
- `executar_tudo.sh`, `executar_tudo.ps1` e `Executar_Tudo.bat` em `scripts/` — hub de menu único para verificar hashes, regenerar hashes e buscar ferramentas, sem precisar lembrar o nome de cada script.

### Conhecido
- `rufus`, `dbeavercommunity`, `insomnia` e `nasm` ficaram com `arquivo: []` — sem binário correspondente em `FERRAMENTAS/` no momento desta atualização.

---

## [1.4] — Junho/2026
 
### Adicionado
- `buscar_manifesto.ps1` e `Buscar_Manifesto.bat` em `scripts/` — equivalentes Windows do buscador interativo
- `bootstrap_catalogo.ps1` e `Bootstrap_Catalogo.bat` em `scripts/` — equivalentes Windows do bootstrap do catálogo

---

## [1.3] — Junho/2026

### Adicionado
- `buscar_manifesto.sh` em `Scripts/` — buscador interativo do manifesto com menu de terminal.
  - Busca por: nome, alias, categoria, tipo ou sistema.
  - Saída: nome da ferramenta e documentação correspondente.
  - Um parâmetro por vez para manter modularidade e facilitar expansão futura.

### A fazer
- `buscar_manifesto.ps1` e `Buscar_Manifesto.bat` — equivalentes Windows do buscador.
- Expansão do buscador para múltiplos parâmetros simultâneos.

---

## [1.2] — Junho/2026

### Adicionado
- Categoria **Sistema / Linux** no Índice Geral com 20 ferramentas de monitoramento e diagnóstico:
  - Htop, Btop++, Nvtop, CPU-X, Hardinfo2, LM-Sensors, Smartmontools, Iotop, Powertop, GDU, Ncdu, Tmux, Inxi, Journalctl, Dmesg, Stacer, Mission Center, Netdata, LazyDocker, Timeshift
- `GUIA_DE_MONITORAMENTO.md` em `Personal_Doc/` — referência unificada de monitoramento e diagnóstico no Linux, cobrindo ferramentas instaladas e candidatos a instalar com prioridade de instalação
- DBeaver Community e Insomnia adicionados à categoria **Desenvolvimento**
- Seção **Documentação por ferramenta** no Índice Geral apontando para os `.md` individuais
- `README.md` na raiz do repositório com navegação, descrição e estrutura resumida
- `CHANGELOG.md` na raiz do repositório

### Alterado
- Categoria **Desenvolvimento / GPU** renomeada para **Desenvolvimento**
- Índice atualizado de v1.1 para v1.2

---

## [1.1] — (anterior)

### Adicionado
- Estrutura inicial do repositório
- Índice Geral v1.1 com categorias: Hardware/Benchmark, Sistema/Windows, Recuperação/Backup, Rede/Infraestrutura, Reverse Engineering/Forensics, Segurança/Pentest, Virtualização, Laboratório Offline, Criptografia/Senhas, Organização/Utilidades, Desenvolvimento/GPU
- `Autoruns.md` em `Personal_Doc/`
- Scripts de manifesto e verificação de hashes
- `Estrutura_do_Projejto.md` na raiz
