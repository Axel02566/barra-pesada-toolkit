# MangoHud

## Função
Overlay de monitoramento de hardware open-source para Linux e Windows.

Permite:
- exibir FPS, frametime, uso de CPU e GPU;
- monitorar temperatura, clock e uso de memória;
- overlay customizável via arquivo de configuração;
- captura de benchmark em arquivo de log.

---

## Usar quando
- Benchmark de jogos no Linux;
- Monitorar hardware em tempo real durante jogos;
- Substituir RTSS no Linux;
- Capturar dados de performance para análise posterior.

---

## Recursos importantes
- overlay in-game leve e customizável;
- suporte a Vulkan e OpenGL;
- integração com Steam e Proton;
- log de benchmark em CSV;
- frametime graph;
- configuração via arquivo `.conf`;
- sem dependência de software proprietário.

---

## Instalação Linux
Ubuntu/Debian:
```bash
sudo apt install mangohud
```

Ou via repositório do projeto para versão mais recente:
```bash
# Ver releases em:
# https://github.com/flightlessmango/MangoHud/releases/latest
```

---

## Ativar no Steam
Nas propriedades do jogo, em "Launch Options":
```bash
MANGOHUD=1 %command%
```

Ou ativar globalmente via Steam → Settings → Compatibility.

---

## Configuração básica
Arquivo de config em:
```
~/.config/MangoHud/MangoHud.conf
```

Exemplo mínimo:
```
fps
cpu_stats
gpu_stats
ram
```

---

## Cuidado
- Alguns jogos via Proton podem ter comportamento inesperado;
- Overlay muito carregado pode afetar levemente a performance;
- Versão Windows ainda menos madura que a Linux.

---

## Recomendações
- Usar GOverlay como interface gráfica para configurar o MangoHud;
- Combinar com LACT para controle de GPU e monitoramento completo;
- Ativar log para capturar benchmarks e comparar sessões.

---

## Observações pessoais
Ferramenta padrão para benchmark no Linux.

Complementa o LACT no lado Linux do toolkit:
- LACT → controle e configuração de GPU;
- MangoHud → overlay e monitoramento durante uso.

Equivalente Linux ao combo HWiNFO64 + RTSS do Windows.

---

## Plataforma
`[Linux / Windows]`

---

## GitHub
https://github.com/flightlessmango/MangoHud

## Releases
https://github.com/flightlessmango/MangoHud/releases/latest

## Lembrete
Consultar documentação oficial sobre:
- opções de configuração do .conf;
- integração com Steam/Proton;
- formato de log de benchmark;
- GOverlay como frontend gráfico.
