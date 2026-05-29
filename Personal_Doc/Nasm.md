# nasm

## Função
Assembler x86/x86-64 de uso geral, portátil e amplamente adotado em desenvolvimento de baixo nível.

Usado para:
- escrever código Assembly diretamente;
- gerar binários, objetos linkáveis ou imagens de boot;
- desenvolvimento de bootloaders e kernels;
- criação de shellcode;
- aprendizado de arquitetura x86/x86-64;
- CTF e pesquisa de segurança.

---

## Suporta
- x86 (16, 32 bits);
- x86-64 (64 bits);
- formatos de saída: ELF, PE, bin, COFF, Mach-O;
- sintaxe Intel (padrão);
- macros e diretivas avançadas.

---

## Usar quando
- Escrever Assembly manualmente para estudo ou projeto;
- Desenvolver bootloaders ou kernels bare metal;
- Criar programas em Assembly sem depender do GCC/gas;
- Testar instruções específicas da arquitetura x86;
- Trabalhar com shellcode em ambiente controlado.

---

## Recursos importantes
- Sintaxe Intel (mesma usada pelo Ghidra e x64dbg);
- Suporte a múltiplos formatos de saída;
- Macros e pré-processador próprio;
- Compatível com linkers como ld e link.exe;
- Levíssimo e sem dependências externas.

---

## Cuidado
- Sintaxe Intel difere da AT&T usada pelo gas/GCC por padrão.
- Erros de segmentação não têm mensagem clara — depuração exige GDB ou x64dbg.
- Shellcode em ambiente não isolado representa risco real.

---

## Observações pessoais
Ferramenta essencial para qualquer trabalho sério com Assembly x86.
Sintaxe alinhada com Ghidra e x64dbg — facilita a transição entre escrever e analisar código.
Ponto de entrada natural para desenvolvimento de OS e estudo de arquitetura.

---

## Site oficial
https://www.nasm.us/

## GitHub
https://github.com/netwide-assembler/nasm

## Lembrete
Consultar documentação oficial sobre:
- diretivas de seção (section .text, .data, .bss);
- formatos de saída (elf64, bin, pe32);
- macros e uso do pré-processador;
- integração com ld para geração de executável completo.
