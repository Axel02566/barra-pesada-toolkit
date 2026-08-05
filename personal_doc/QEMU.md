# QEMU

## Função
Emulador e virtualizador de máquina leve, scriptável e multiplataforma.

Permite:
- emular arquiteturas de CPU diferentes da do host (ARM, RISC-V, MIPS, etc.);
- virtualizar com aceleração de hardware (KVM no Linux, WHPX/HAXM no Windows);
- criar VMs descartáveis via linha de comando, sem instalador pesado.

---

## Usar quando
- Precisar rodar/testar outra arquitetura de CPU num host x86 (ex: binário ARM);
- Montar uma VM rápida e descartável pra analisar binário/firmware suspeito;
- Precisar de ambiente de virtualização portátil, sem depender de instalador GUI grande.

---

## Recursos importantes
- Emulação de múltiplas arquiteturas de CPU;
- snapshots;
- aceleração via KVM (Linux) ou WHPX/HAXM (Windows);
- totalmente scriptável via linha de comando.

---

## Cuidado
- Sem aceleração de hardware (KVM/WHPX), emulação cross-arch fica bem mais lenta;
- configuração via CLI tem curva de aprendizado maior que uma GUI tipo VirtualBox.

---

## Observações pessoais
Mais alinhado com a filosofia portátil/offline do toolkit do que o VirtualBox — sem instalador GUI pesado, e cobre diretamente o "malware real deve ser analisado em VM isolada" que os docs de Ghidra e DIE já mencionam.

---

## Site oficial
https://www.qemu.org/

## GitHub
https://github.com/qemu/qemu

## Lembrete
Consultar documentação oficial sobre:
- aceleração KVM (Linux) e WHPX (Windows);
- snapshots de VM;
- emulação de arquitetura ARM/RISC-V.
