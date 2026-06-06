# BARRA_PESADA — Estrutura do Projeto

```text
BARRA_PESADA/
│
├── documentacao/
│   │
│   ├── Hardware_Benchmark/
│   ├── Sistema_Windows/
│   ├── Recuperacao_Backup/
│   ├── Rede_Infraestrutura/
│   ├── Reverse_Engineering/
│   ├── Seguranca_Pentest/
│   ├── Virtualizacao/
│   ├── Criptografia/
│   ├── Organizacao_Utilidades/
│   ├── Desenvolvimento_GPU/
│   └── Laboratorio_Offline/
│
├── ferramentas/
│   │
│   ├── windows/
│   ├── linux/
│   ├── bootaveis/
│   ├── portable/
│   ├── instaladores/
│   └── isos/
│
├── manifesto/
│   │
│   ├── manifesto_auto.json
│   ├── catalogo_manual.json
│   ├── aliases.json
│   └── versoes.json
│
├── saude_dos_arquivos/
│   │
│   ├── hashes_sha256.txt
│   ├── verificar_hashes.ps1
│   ├── gerar_hashes.ps1
│   ├── verificar_hashes.bat
│   └── gerar_hashes.bat
│
├── scripts/
│   │
│   ├── executar_tudo.ps1
│   ├── executar_tudo.bat
│   ├── gerar_manifesto.ps1
│   ├── gerar_manifesto.bat
│   ├── verificar_manifesto.ps1
│   ├── verificar_manifesto.bat
│   ├── gerar_indice.ps1
│   └── gerar_indice.bat
│
├── atalhos_windows/
│   │
│   ├── Event Viewer
│   ├── services.msc
│   ├── gpedit.msc
│   ├── msconfig
│   ├── Resource Monitor
│   └── etc...
│
├── arquivos_txt/
│   │
│   ├── Recuperacao_Ventoy.txt
│   ├── Comandos_PowerShell_CMD.txt
│   ├── lista_de_programas.txt
│   └── etc...
│
├── backups/
│   │
│   ├── snapshots/
│   ├── recovery/
│   └── exports/
│
├── README.md
├── LICENSE
├── INDICE_GERAL.md
├── RECOVERY_NOTES.md
└── CHANGELOG.md
```

---

# Filosofia estrutural

* documentação separada das ferramentas;
* automação separada do conteúdo;
* manifesto separado do índice;
* hashes separadas dos scripts;
* metadata manual separada da automática;
* tudo independente da letra do disco;
* foco em portabilidade, auditoria e recuperação.

---

# Objetivo do projeto

Criar um toolkit portátil, modular e auditável para:

* recuperação;
* troubleshooting;
* benchmark;
* engenharia reversa;
* pentest;
* virtualização;
* automação;
* laboratório offline;
* preservação de conhecimento técnico.

---

# Filosofia

"Jack of all trades, master of none, but oftentimes better than master of one."

"Buscar conhecimento."
