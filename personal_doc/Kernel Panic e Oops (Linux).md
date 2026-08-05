# Kernel Panic e Oops (Linux)

## O que é
Documentação oficial do próprio kernel Linux sobre como interpretar um *oops* (erro recuperável, kernel continua rodando) ou um *panic* (erro fatal, sistema trava) — o equivalente funcional ao Bug Check Code Reference do Windows, só que sem um catálogo único de "códigos": a investigação é feita lendo o stack trace e os símbolos de depuração.

---

## Quando consultar
- Depois de um kernel panic/oops, pra saber como ler o stack trace exibido;
- Configurar captura de dump via **kdump** pra investigar o crash depois, com calma;
- Troubleshooting de módulo de kernel ou driver instável.

---

## Estrutura resumida
- `Documentation/admin-guide/bug-hunting.rst` — como interpretar um oops e localizar a linha de código responsável;
- `Documentation/admin-guide/kdump/kdump.rst` — como configurar a captura de dump (vmcore) em caso de panic.

---

## Cuidado
- Sem os símbolos de depuração do kernel em uso (`kernel-debuginfo` ou equivalente), o stack trace de um oops/panic é praticamente ilegível;
- kdump precisa estar configurado *antes* do crash acontecer — não adianta configurar depois do fato.

---

## Observações pessoais
Faz par direto com o `Kernel Debug Symbols (dbgsym)` que já está no toolkit, e com o `crash` (ferramenta de análise de vmcore) — os três juntos fecham o ciclo equivalente ao WinDbg + Bug Check Reference do lado Windows.

---

## Site oficial
https://docs.kernel.org/admin-guide/bug-hunting.html
https://docs.kernel.org/admin-guide/kdump/kdump.html

## Lembrete
Consultar documentação oficial sobre:
- configuração de kdump (reserva de memória pro kernel de captura);
- leitura de stack trace com símbolos de depuração;
- uso combinado com o utilitário `crash`.
