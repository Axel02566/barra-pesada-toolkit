# CHANGELOG

Registro de alterações do BARRA PESADA — Toolkit.

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
