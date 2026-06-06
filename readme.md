# BARRA PESADA — Toolkit

Toolkit portátil e modular para diagnóstico, recuperação, manutenção, segurança e laboratório offline.

---

## Navegação rápida

- [Índice Geral](./Índice_Geral-v1.2.md) — lista completa de ferramentas por categoria
- [Estrutura do Projeto](./Estrutura_do_Projejto.md) — mapa de diretórios e filosofia organizacional
- [Scripts](./Scripts/) — automação de manifesto, hashes e índice
- [Documentação por ferramenta](./Personal_Doc/) — guias e referências individuais

---

## O que é

Uma coleção curada de ferramentas, scripts e documentação técnica organizada para funcionar de forma independente — sem acesso à internet, sem instalador central, sem dependência de letra de disco.

Cobre desde recuperação de boot e análise forense até monitoramento de hardware e pentest, com foco em portabilidade e auditabilidade.

---

## Estrutura resumida

```
BARRA_PESADA/
├── documentacao/       — guias por área (hardware, segurança, recuperação...)
├── ferramentas/        — binários e instaladores organizados por plataforma
├── scripts/            — automação (manifesto, hashes, índice)
├── manifesto/          — catálogo de arquivos e metadados
├── saude_dos_arquivos/ — hashes SHA-256 e scripts de verificação
├── backups/            — snapshots e exports
├── Personal_Doc/       — documentação individual por ferramenta
└── Índice_Geral.md     — ponto de entrada principal
```

---

## Plataformas cobertas

- Windows — ferramentas nativas, Sysinternals, recuperação, pentest
- Linux — monitoramento, diagnóstico, módulos de kernel, containers
- Bootável — MemTest86, Ventoy, ambientes de recuperação

---

## Filosofia

"Jack of all trades, master of none, but oftentimes better than master of one."

"Buscar conhecimento."

---

## Licença

MIT — veja [LICENSE](./LICENSE).
