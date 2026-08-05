# iperf3

## Função
Ferramenta de teste de banda/throughput de rede entre dois pontos.

Permite:
- medir velocidade real entre dois hosts;
- testar TCP e UDP;
- medir jitter e perda de pacote (modo UDP).

---

## Usar quando
- Medir velocidade real de link entre dois pontos da rede;
- Diagnosticar gargalo de rede;
- Validar upgrade de infraestrutura (cabo, switch, roteador, placa de rede).

---

## Recursos importantes
- Modo cliente/servidor (`-s` / `-c`);
- suporte a TCP e UDP;
- relatório de jitter/perda de pacote em UDP;
- múltiplos streams paralelos (`-P`).

---

## Cuidado
- O teste satura o link — evitar rodar em rede de produção sem aviso prévio;
- resultado em UDP não reflete necessariamente a performance real de uma aplicação.

---

## Observações pessoais
Complementa o lado de benchmark de hardware que já é forte no toolkit (CPU, disco, memória) — faltava justamente medir rede com o mesmo rigor.

---

## Site oficial
https://iperf.fr/

## GitHub
https://github.com/esnet/iperf

## Lembrete
Consultar documentação oficial sobre:
- diferença entre modo TCP e UDP;
- uso de streams paralelos (`-P`);
- formatos de relatório (`-J` pra JSON).
