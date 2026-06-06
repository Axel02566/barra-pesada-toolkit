# CHANGELOG

Registro de alterações do BARRA PESADA — Toolkit.

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
