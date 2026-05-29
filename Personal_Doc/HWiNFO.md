# HWiNFO

## Função
Ferramenta avançada de monitoramento e diagnóstico de hardware.

Permite visualizar:
- temperaturas;
- clocks;
- tensões;
- sensores;
- consumo;
- throttling;
- VRM;
- informações detalhadas da CPU/GPU/RAM.

Extremamente útil para:
- diagnóstico térmico;
- troubleshooting;
- análise de estabilidade;
- monitoramento durante estresse.

---

## Usar quando
- Verificar thermal throttling;
- Diagnosticar superaquecimento;
- Confirmar clocks reais;
- Monitorar sensores da CPU/GPU;
- Verificar consumo de energia;
- Conferir informações da memória RAM;
- Monitorar SSD NVMe.

---

## Cuidado
- Alguns sensores EC podem conflitar em notebooks.
- Logging contínuo pode gerar arquivos grandes.
- Não alterar configurações sem saber o impacto.
- Temperaturas em burst podem subir rapidamente em CPUs Intel H-Series.

---

## Leituras importantes
### CPU
- Core Temperature
- Package Temperature
- Core Clocks
- Effective Clocks
- Power Consumption
- Thermal Throttling

### GPU
- GPU Temperature
- Hotspot
- VRAM Temperature
- GPU Power

### SSD
- Drive Temperature
- Percentage Used
- Health Status

---

## Observações pessoais
No Acer:
- temperatura sobe rapidamente em cargas curtas;
- throttling severo ocorre acima de ~90°C;
- útil para validar funcionamento da PTM7950.

---

## Site oficial
https://www.hwinfo.com/

## Documentação
https://www.hwinfo.com/documentation/