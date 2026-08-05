# Manuais de Arquitetura — Intel, AMD, ARM

## O que é
Conjunto de referências oficiais de ISA (instruction set architecture) dos três principais fabricantes de CPU:

- **Intel® 64 and IA-32 Architectures Software Developer's Manual (SDM)** — volumes combinados 1, 2A-D, 3A-D, 4;
- **AMD64 Architecture Programmer's Manual (APM)** — volumes 1-5;
- **Arm® Architecture Reference Manual for A-profile architecture (Arm ARM)** — cobre AArch64/AArch32.

---

## Quando consultar
- Ler output de disassembly do Ghidra/x64dbg/objDump que não bate com o esperado;
- Entender o que um MSR específico faz (ThrottleStop e UXTU mexem nisso diretamente);
- Escrever ou entender código em nasm;
- Pesquisa de vulnerabilidade em nível de hardware (ex: classe Spectre/Meltdown).

---

## Estrutura resumida
- **Intel SDM**: Vol. 1 (arquitetura básica) — Vol. 2 (instruction set A-Z) — Vol. 3 (system programming: memória, interrupção, virtualização) — Vol. 4 (MSRs).
- **AMD APM**: Vol. 1 (aplicação) — Vol. 2 (sistema) — Vol. 3-5 (instruction set reference).
- **Arm ARM**: modelo de execução, conjunto de instruções A64/A32/T32, sistema de memória.

---

## Cuidado
- São documentos enormes (o SDM sozinho passa de 5000 páginas) — usar como referência de consulta pontual, não leitura corrida;
- as versões são atualizadas periodicamente — a cópia local pode ficar desatualizada, vale checar a fonte oficial de tempos em tempos.

---

## Observações pessoais
Referência que sustenta tudo que já está em Reverse Engineering/Forensics — Ghidra, x64dbg, nasm e objDump geram ou consomem exatamente o que esses manuais documentam.

---

## Links oficiais
- Intel SDM: https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
- AMD APM: https://docs.amd.com (buscar "AMD64 Architecture Programmer's Manual")
- Arm ARM: https://developer.arm.com/documentation/ddi0487/latest

## Lembrete
Consultar documentação oficial sobre:
- versão/revisão mais recente de cada manual antes de arquivar localmente;
- índice cruzado entre instrução e capítulo (o combined volume da Intel já vem com isso pronto).
