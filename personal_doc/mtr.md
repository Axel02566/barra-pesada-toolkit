# mtr

## Função
Combina ping e traceroute em uma ferramenta única, contínua e em tempo real.

Permite:
- ver a rota até um destino;
- monitorar latência e perda de pacote por salto (hop);
- atualização contínua ao invés de uma medição estática.

---

## Usar quando
- Diagnosticar latência ou perda de pacote intermitente;
- Identificar em qual salto da rede o problema está acontecendo;
- Monitorar uma rota por um período mais longo.

---

## Recursos importantes
- Atualização contínua (ao contrário do traceroute tradicional, que é uma foto única);
- modo relatório (`--report`) pra output não interativo, bom pra logging;
- suporte a IPv4 e IPv6.

---

## Cuidado
- Alguns provedores/roteadores intermediários bloqueiam ICMP por política, o que gera falso positivo de "perda" em hops que só não respondem — não necessariamente há problema real ali.

---

## Observações pessoais
Resolve o clássico "minha internet está lenta" muito mais rápido do que rodar ping e traceroute separados e tentar cruzar os dados na mão.

---

## GitHub
https://github.com/traviscross/mtr

## Lembrete
Consultar documentação oficial sobre:
- modo relatório (`--report`, `--report-cycles`);
- interpretação correta de perda de pacote por hop;
- uso com IPv6 (`-6`).
