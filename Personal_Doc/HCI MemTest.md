# HCI MemTest

## Função
Ferramenta de teste de estabilidade e integridade de memória RAM rodando dentro do Windows.

Permite:
- detectar erros de RAM;
- verificar estabilidade de timings;
- testar RAM sem necessidade de boot externo;
- validar upgrade ou overclock de memória.

---

## Usar quando
- Verificar estabilidade da RAM dentro do Windows;
- Validar upgrade sem reiniciar;
- Diagnóstico rápido de instabilidade;
- Complementar o MemTest86 em testes do dia a dia.

---

## Recursos importantes
- teste dentro do Windows sem reboot;
- ajuste manual do tamanho de memória a testar;
- suporte a múltiplas instâncias simultâneas;
- log de erros detalhado;
- versão portátil sem instalação.

---

## Como usar corretamente
Para testar toda a RAM disponível:
1. Verificar no Task Manager quanta RAM está livre;
2. Abrir múltiplas instâncias do HCI MemTest;
3. Distribuir a memória livre entre as instâncias;
4. Rodar por pelo menos 200% de cobertura para resultado confiável.

---

## Cuidado
- Testar apenas a RAM livre, não o total instalado.
- Instâncias demais podem travar o sistema.
- Não substitui o MemTest86 para diagnóstico profundo.
- Pode provocar instabilidade se a RAM tiver timings marginais.

---

## Diferença em relação ao MemTest86
- MemTest86 → boot externo, acesso direto à RAM, mais completo;
- HCI MemTest → roda dentro do Windows, mais prático para verificações rápidas.

Os dois se complementam; não são excludentes.

---

## Observações pessoais
Ferramenta muito útil para:
- validar RAM rapidamente sem reiniciar;
- verificar dual-channel após upgrade;
- diagnóstico inicial antes de recorrer ao MemTest86.

---

## Plataforma
`[Windows]`

---

## Site oficial
https://hcidesign.com/memtest/

## Lembrete
Consultar documentação oficial sobre:
- cálculo de instâncias;
- interpretação de erros;
- diferença entre versão free e Pro.
