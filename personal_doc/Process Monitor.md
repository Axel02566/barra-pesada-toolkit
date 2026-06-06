# Process Monitor

## Função
Ferramenta avançada de monitoramento em tempo real da Sysinternals.

Captura:
- acesso a arquivos;
- registro;
- processos;
- threads;
- rede;
- DLLs;
- eventos internos do Windows.

---

## Usar quando
- Programa não abre;
- Driver falha;
- Sistema gera erro estranho;
- Diagnóstico avançado;
- Engenharia reversa leve.

---

## Recursos importantes
- filtros;
- stack traces;
- export de logs;
- captura em tempo real.

---

## Cuidado
- Gera MUITOS eventos rapidamente.
- Sem filtros o log vira caos.
- Captura prolongada gera arquivos enormes.

---

## Fluxo recomendado
1. Limpar captura;
2. Criar filtro;
3. Reproduzir problema;
4. Analisar eventos relevantes.

---

## Observações pessoais
Ferramenta absurdamente poderosa.

Praticamente:
- estetoscópio;
- microscópio;
- e scanner do Windows juntos.

---

## Site oficial
https://learn.microsoft.com/sysinternals/downloads/procmon

## Lembrete
Consultar documentação oficial sobre:
- filtros;
- boot logging;
- stack analysis.