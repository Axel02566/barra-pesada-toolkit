# ParamSpider

## Função
Ferramenta de recon passivo pra descoberta de parâmetros GET em aplicações web.

Permite:
- minerar URLs históricas de um domínio via Wayback Machine;
- extrair parâmetros GET únicos sem interagir diretamente com o alvo;
- filtrar extensões irrelevantes ("boring URLs");
- mapear candidatos a ponto de injeção antes do scan ativo.

---

## Usar quando
- Reconhecimento inicial em pentest web autorizado;
- Bug bounty;
- Levantamento de superfície de ataque antes de usar Burp Suite/OWASP ZAP;
- Estudo de padrões de parâmetros de um domínio.

---

## Recursos importantes
- Suporte a múltiplos domínios;
- exclusão de extensões (`--exclude`);
- profundidade de busca pra parâmetros aninhados (`--level`);
- placeholder customizável (padrão `FUZZ`, pronto pra fuzzing);
- combina bem com GF (Grep Fu) pra filtrar parâmetros "juicy".

---

## Cuidado
- 100% passivo (não gera tráfego direto no alvo), mas ainda é recon ofensivo — usar só em escopo autorizado;
- taxa de falso positivo é alta (dados do Wayback Machine podem estar desatualizados ou o endpoint já não existir mais);
- depende de acesso à internet (consulta a API do Wayback Machine);
- existem vários forks com manutenção variável (original: devanshbatham; forks ativos: 0xKayala, Elsfa7-110, e um rewrite em Bun/TS do binsarjr) — checar qual está mantido antes de fixar a versão.

---

## Observações pessoais
Complementa Burp Suite/OWASP ZAP como etapa de recon passivo — levanta candidatos a ponto de injeção sem tocar no alvo, pra depois alimentar as ferramentas de scan ativo.

---

## GitHub
https://github.com/devanshbatham/ParamSpider

## Lembrete
Consultar documentação oficial sobre:
- flags de exclusão e nível de profundidade;
- uso combinado com GF pra filtrar parâmetros relevantes;
- qual fork está ativamente mantido no momento da instalação.
