# Universal x86 Tuning Utility (UXTU)

## Função
Alternativa leve ao Ryzen Master e Intel XTU para laptops e desktops x86.

Permite:
- controle de TDP;
- ajuste de power limits;
- undervolt (quando disponível);
- monitoramento de CPU/GPU;
- automação de perfis;
- Adaptive Mode dinâmico.

Desenvolvido pelos criadores do Ryzen Controller e Power Control Panel.

---

## Usar quando
- Diagnosticar thermal throttling;
- Ajustar power limits;
- Monitorar desempenho em tempo real;
- Criar perfis de performance;
- Substituir software proprietário do fabricante.

---

## Recursos importantes
- Premade Presets;
- Custom Presets;
- Adaptive Mode (TDP dinâmico por temperatura);
- Game Library;
- System Info;
- Automations.

---

## Adaptive Mode
Monitora temperatura continuamente e ajusta TDP dinamicamente para manter o melhor desempenho possível dentro dos limites térmicos.

Útil para:
- evitar throttling agressivo;
- manter estabilidade;
- reduzir intervenção manual.

---

## Compatibilidade
- Funciona melhor em CPUs Zen-based (AMD Ryzen);
- Suporte a Intel a partir da 4ª geração;
- Focado em laptops, mas funciona em desktops.

---

## Cuidado
- Alterações de TDP podem causar instabilidade;
- Undervolt pode estar bloqueado por firmware;
- Fazer mudanças graduais;
- Monitorar temperatura durante testes.

---

## Recomendações
- Usar junto com HWiNFO para monitoramento;
- Combinar com FurMark/Prime95 para validar estabilidade;
- Criar perfis separados por uso (idle, trabalho, jogos).

---

## Observações pessoais
No Acer com i5-13420H:
- undervolt bloqueado via firmware (mitigação Plundervolt da Intel, presente desde a 10ª geração);
- uso focado em controle de power limits e Adaptive Mode;
- alternativa mais moderna e visual ao ThrottleStop;
- clock máximo travado via plano de energia avançado do Windows como contorno ao throttling.

Ferramenta útil mesmo com restrições de firmware, principalmente pelo Adaptive Mode e monitoramento integrado.

---

## Plataforma
`[Windows]`

---

## Site oficial / GitHub
https://github.com/JamesCJ60/Universal-x86-Tuning-Utility

## Releases
https://github.com/JamesCJ60/Universal-x86-Tuning-Utility/releases/latest

## Lembrete
Consultar documentação oficial sobre:
- Adaptive Mode;
- compatibilidade por geração de CPU;
- power limits suportados;
- perfis e automações.
