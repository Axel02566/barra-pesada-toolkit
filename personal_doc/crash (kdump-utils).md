# crash (kdump-utils)

## Função
Utilitário de análise de crash dump do kernel Linux (vmcore), integrado com gdb — o equivalente funcional ao WinDbg no lado Linux.

Permite:
- investigar um vmcore gerado pelo kdump após um kernel panic;
- analisar sistema Linux rodando ao vivo, sem esperar um crash;
- rodar qualquer comando do gdb por baixo, além dos comandos próprios de análise de kernel.

---

## Usar quando
- Investigar a causa raiz de um kernel panic a partir do vmcore capturado pelo kdump;
- Analisar stack trace, estrutura de dados de kernel e memória após um crash;
- Debug ao vivo de um sistema Linux instável, sem precisar esperar ele cair de vez.

---

## Recursos importantes
- Stack trace por processo/CPU;
- disassembly de código-fonte;
- display de variável de kernel e memória;
- qualquer comando do gdb pode ser usado diretamente.

---

## Cuidado
- Exige o pacote `kernel-debuginfo` (ou equivalente) correspondente exatamente à versão do kernel que gerou o vmcore — sem isso, a análise fica incompleta ou impossível;
- kdump precisa estar configurado e com memória reservada *antes* do crash acontecer.

---

## Observações pessoais
Faz par com o `Kernel Debug Symbols (dbgsym)` que já está no toolkit e com a doc de Kernel Panic/Oops — os três juntos fecham, do lado Linux, o mesmo ciclo que WinDbg + Bug Check Reference fecham no Windows.

---

## GitHub
https://github.com/crash-utility/crash

## Lembrete
Consultar documentação oficial sobre:
- configuração de kdump e reserva de `crashkernel`;
- instalação do `kernel-debuginfo` correspondente;
- comandos básicos de análise (`bt`, `ps`, `kmem`, `log`).
