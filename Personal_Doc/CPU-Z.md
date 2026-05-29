# CPU-Z

## Função
Ferramenta leve para identificação de hardware.

Mostra:
- CPU;
- RAM;
- placa-mãe;
- clocks;
- cache;
- chipset;
- SPD da memória.

---

## Usar quando
- Confirmar especificações da CPU;
- Verificar frequência da RAM;
- Conferir dual-channel;
- Identificar modelo da placa-mãe;
- Validar clocks em tempo real.

---

## Cuidado
- Frequência DDR aparece pela metade.

Exemplo:
3200 MHz DDR → CPU-Z mostra ~1600 MHz.

---

## Abas importantes

### CPU
Informações do processador.

### Memory
Estado atual da RAM:
- frequência;
- timings;
- dual-channel.

### SPD
Informações individuais de cada pente.

---

## Observações pessoais
Útil após upgrade de RAM para:
- verificar dual-channel;
- confirmar JEDEC/XMP;
- validar compatibilidade.

---

## Histórico importante
Em abril de 2026, o site oficial da CPUID sofreu um ataque de supply-chain.

Uma API secundária foi comprometida por aproximadamente 6 horas (9 a 10 de abril de 2026), redirecionando os links de download para instaladores trojanizados hospedados em infraestrutura controlada pelos atacantes.

O instalador malicioso incluía o executável legítimo do CPU-Z acompanhado de uma DLL falsa (CRYPTBASE.dll), que ao ser carregada entregava o STX RAT — um infostealer operando quase inteiramente em memória.

A CPUID confirmou que os arquivos originais assinados não foram modificados; apenas os links de download foram redirecionados. O problema foi corrigido ainda no dia 10 de abril de 2026.

A versão armazenada neste pendrive foi baixada em 06/05/2026, após a correção.

Por isso:
- sempre verificar hash antes de instalar;
- confirmar que o download veio do site oficial;
- manter atenção a futuras ocorrências.

---

## Site oficial
https://www.cpuid.com/softwares/cpu-z.html

## Lembrete
Consultar documentação oficial sobre:
- versões recentes;
- compatibilidade de hardware;
- leituras de frequência DDR.
