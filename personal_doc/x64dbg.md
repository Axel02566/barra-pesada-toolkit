# x64dbg
# snapshot_2025-08-19_19-40.zip ( nome original do download )

## Função
Debugger open-source para Windows focado em:
- engenharia reversa;
- análise dinâmica;
- debugging;
- análise de malware;
- pesquisa de binários;
- tracing de execução.

Suporta:
- x86;
- x64;
- EXEs;
- DLLs;
- attach em processos vivos.

---

## Usar quando
- Analisar comportamento de programas;
- Fazer debugging;
- Estudar execução de binários;
- Investigar malware;
- Observar chamadas internas;
- Inspecionar memória;
- Pesquisar fluxo de execução.

---

## Recursos importantes
- breakpoints;
- step-by-step execution;
- tracing;
- memory dump;
- disassembler;
- patching;
- expression parser;
- análise de registradores;
- stack inspection;
- plugin support;
- scripting;
- conditional breakpoints.

---

## Conceitos importantes
### Step Into
Entra dentro da função/chamada atual.

### Step Over
Executa a função sem entrar nela.

### Breakpoint
Pausa execução em ponto específico.

### Memory Dump
Visualização de memória em tempo real.

### Registers
Estado interno da CPU durante execução.

---

## Cuidado
- Uso incorreto pode causar:
  - travamentos;
  - corrupção;
  - comportamento inesperado.
- Não executar binários suspeitos no sistema principal.
- Ideal utilizar:
  - VM;
  - sandbox;
  - ambiente isolado.

---

## Recomendações
- Combinar com:
  - Ghidra;
  - PE-bear;
  - DIE;
  - Wireshark;
  - Process Monitor;
  - Process Explorer.
- Usar snapshots em VM antes de testes perigosos.
- Documentar alterações/paches realizados.

---

## Observações pessoais
Ferramenta extremamente poderosa para:
- reversing;
- malware analysis;
- CTF;
- pesquisa;
- debugging avançado.

Muito utilizada em:
- segurança ofensiva;
- análise defensiva;
- pesquisa acadêmica;
- engenharia reversa.

Praticamente um dos pilares modernos do reversing em Windows.

---

## Limitações
- Usermode debugger;
- não substitui debugger kernel;
- algumas proteções anti-debug podem interferir;
- malware avançado pode detectar debugger.

---

## Integrações úteis
- Ghidra → análise estática;
- x64dbg → análise dinâmica;
- volatility3 → análise pós-memória;
- Wireshark → análise de rede;
- Process Monitor → comportamento do sistema.

---

## Site oficial
https://x64dbg.com/

## Documentação oficial
https://help.x64dbg.com/en/latest/

## GitHub
https://github.com/x64dbg/x64dbg

---

## Lembrete
Consultar documentação oficial sobre:
- breakpoints;
- scripting;
- tracing;
- plugins;
- anti-debug;
- memory analysis;
- debugging workflow.