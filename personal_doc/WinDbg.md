# WinDbg

## Função
Debugger oficial da Microsoft — analisa dump de crash, depura processo em modo usuário e kernel, examina registrador e memória.

Permite:
- abrir e analisar arquivo `.dmp` gerado após um BSOD;
- depurar driver em modo kernel;
- depurar aplicação em modo usuário;
- Time Travel Debugging (TTD) — gravar e reproduzir execução passo a passo.

---

## Usar quando
- Investigar a causa raiz de um BSOD a partir do dump gerado;
- Depurar driver ou serviço que está causando instabilidade;
- Cruzar um bug check code com os parâmetros reais do crash (via `!analyze -v`).

---

## Recursos importantes
- `!analyze -v` — análise automática do crash;
- suporte a símbolos de depuração (Microsoft Symbol Server);
- Time Travel Debugging (TTD);
- scripting e extensões (SOS, MEX, WinObjEx64, entre outras).

---

## Cuidado
- Análise de dump kernel exige símbolos corretos pra versão exata do Windows — sem eles, o `!analyze` erra ou fica incompleto;
- curva de aprendizado real pra além do `!analyze -v` básico.

---

## Observações pessoais
É a peça que faltava pro Bug Check Code Reference render valor prático — a referência lista o significado do código, o WinDbg mostra o que de fato aconteceu no crash real.

---

## Site oficial
https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/

## Lembrete
Consultar documentação oficial sobre:
- configuração do symbol path (`.symfix`, `.sympath+`);
- uso do `!analyze -v`;
- Time Travel Debugging (TTD).
