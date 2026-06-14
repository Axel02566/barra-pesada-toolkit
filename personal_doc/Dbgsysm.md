# Kernel Debug Symbols (dbgsym)

## Função

Pacotes contendo símbolos de depuração para o kernel Linux.

Usados para:

* análise de kernel panic;
* análise de crash dumps;
* investigação de Oops;
* análise de stack traces;
* debugging avançado;
* análise forense de incidentes.

---

## O que fazem

Traduzem endereços de memória e funções internas do kernel para nomes legíveis.

Sem símbolos:

```text
0xffffffff810af24c
```

Com símbolos:

```text
do_page_fault()
```

Facilitando a investigação de falhas e travamentos.

---

## Usar quando

* Investigar kernel panic;
* Investigar Oops;
* Analisar vmcore;
* Utilizar crash;
* Utilizar gdb em dumps do kernel;
* Realizar debugging avançado.

---

## Não usar quando

* O sistema está funcionando normalmente;
* Não existem logs ou dumps para analisar;
* O problema não envolve kernel;
* O objetivo é apenas monitoramento de hardware.

---

## Dependências

Pode exigir:

* crash;
* gdb;
* kdump;
* vmcore;
* logs preservados do incidente.

---

## Recursos importantes

* Resolução de símbolos do kernel;
* Stack traces legíveis;
* Análise de dumps;
* Correlação com logs;
* Identificação de funções envolvidas no crash.

---

## Limitações

* Dependem da versão exata do kernel.
* Não corrigem problemas.
* Não garantem descoberta da causa raiz.
* Pouco úteis sem dumps ou logs válidos.
* Eventos severos podem destruir evidências antes do registro.

---

## Cuidado

* Consomem bastante espaço em disco.
* Algumas versões podem ocupar vários GB.
* Devem corresponder exatamente ao kernel analisado.
* Símbolos incorretos podem gerar interpretações erradas.

---

## Observações pessoais

Ferramenta extremamente útil para investigação de baixo nível.

Não é algo que precisa ficar instalado permanentemente em todas as máquinas, mas vale conhecer e manter documentado.

Em muitos incidentes ela não resolve o problema sozinha, porém pode transformar um dump ilegível em informação útil.

---

## Site oficial

https://wiki.ubuntu.com/DebuggingKernel

---

## Lembrete

Consultar documentação oficial sobre:

* kdump;
* crash;
* vmcore;
* kernel panic;
* Oops;
* análise de stack traces.

---

## Lição aprendida

A presença dos símbolos de depuração não substitui a coleta adequada de evidências.

Se os logs ou dumps não foram preservados durante o incidente, os símbolos podem ter utilidade limitada.
