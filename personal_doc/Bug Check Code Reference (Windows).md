# Bug Check Code Reference (Windows)

## O que é
Referência oficial da Microsoft com todo código de bug check (stop code / BSOD) do Windows — o que cada código significa e como investigar.

---

## Quando consultar
- Depois de um BSOD, pra entender o significado do stop code exibido;
- Durante análise de dump de crash com o WinDbg (`!analyze`), pra interpretar os parâmetros de cada bug check;
- Troubleshooting de driver ou instabilidade recorrente de sistema.

---

## Estrutura resumida
- Lista de códigos (ex: `0x0000001E`, `0x0000009F`, `0x00000133`) com nome, descrição e os 4 parâmetros associados a cada um;
- artigos individuais por código, com causas comuns e passos de investigação.

---

## Cuidado
- A referência sozinha só descreve o código — pra investigar de fato um crash real, é necessário abrir o `.dmp` gerado com o **WinDbg** e rodar `!analyze -v`;
- sem o dump, o código isolado raramente aponta a causa raiz.

---

## Observações pessoais
Só rende valor prático junto do WinDbg — o par dos dois é o que fecha o ciclo de "BSOD aconteceu → código X → dump → causa raiz".

---

## Site oficial
https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/bug-check-code-reference2

## Lembrete
Consultar documentação oficial sobre:
- uso do `!analyze -v` no WinDbg;
- como gerar e coletar o arquivo de dump (`.dmp`) após um crash;
- lista completa de bug checks por versão do Windows.
