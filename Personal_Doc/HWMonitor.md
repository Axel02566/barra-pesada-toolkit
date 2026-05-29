# HWMonitor

## Função
Ferramenta de monitoramento de hardware desenvolvida pela CPUID.

Permite visualizar:
- temperaturas;
- tensões;
- clocks;
- consumo;
- RPM das ventoinhas;
- sensores da placa-mãe;
- informações da CPU e GPU.

---

## Usar quando
- Verificar superaquecimento;
- Diagnosticar thermal throttling;
- Monitorar estabilidade;
- Verificar comportamento térmico;
- Comparar temperaturas antes/depois de manutenção.

---

## Recursos importantes
- leitura de sensores em tempo real;
- monitoramento de CPU/GPU;
- tensão da fonte;
- RPM de ventoinhas;
- temperaturas do sistema.

---

## Cuidado
- Alguns sensores podem reportar valores incorretos dependendo do hardware.
- Nem toda placa-mãe expõe sensores completos.
- Leituras absurdas geralmente indicam incompatibilidade de sensor.

---

## Recomendações
- Comparar resultados com:
  - HWiNFO;
  - BIOS/UEFI;
  - ferramentas do fabricante.
- Usar junto com stress test para diagnóstico térmico.

---

## Observações pessoais
Ferramenta extremamente simples e leve.

Muito útil para:
- diagnóstico rápido;
- verificação de temperatura;
- notebooks;
- PCs antigos.

Menos detalhado que o HWiNFO, porém mais simples de interpretar.

---

## Histórico importante
Em abril de 2026, o site oficial da CPUID sofreu um ataque de supply-chain.

O HWMonitor 1.63 foi a ferramenta que originou a descoberta do incidente — um usuário no Reddit notou que o download oficial retornava um arquivo chamado "HWiNFO_Monitor_Setup.exe" com um instalador em russo, que disparou o Windows Defender imediatamente.

Uma API secundária foi comprometida por aproximadamente 6 horas (9 a 10 de abril de 2026), redirecionando os links de download para instaladores trojanizados. O payload final foi o STX RAT, um infostealer operando quase inteiramente em memória.

A CPUID confirmou que os arquivos originais assinados não foram modificados; apenas os links de download foram redirecionados. O problema foi corrigido ainda no dia 10 de abril de 2026.

A versão armazenada neste pendrive foi baixada em 06/05/2026, após a correção.

Por isso:
- sempre verificar hash antes de instalar;
- confirmar que o download veio do site oficial;
- manter atenção a futuras ocorrências.

---

## Site oficial
https://www.cpuid.com/softwares/hwmonitor.html

## Documentação
https://www.cpuid.com/

## Lembrete
Consultar documentação oficial sobre:
- sensores compatíveis;
- limites térmicos;
- diferenças entre versões Free e Pro.
