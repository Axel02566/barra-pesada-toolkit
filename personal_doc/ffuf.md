# ffuf

## Função
Fuzzer web rápido, escrito em Go — enumeração de diretório, arquivo, subdomínio e parâmetro.

Permite:
- fuzzar qualquer parte de uma requisição HTTP (URL, header, body, parâmetro);
- enumerar diretório/arquivo/vhost de uma aplicação web;
- filtrar resultado por código de status, tamanho ou palavra.

---

## Usar quando
- Enumerar conteúdo/diretório de uma aplicação web em pentest autorizado;
- Fuzzar um parâmetro descoberto previamente (ex: pelo ParamSpider);
- Enumeração de vhost/subdomínio.

---

## Recursos importantes
- Extremamente rápido (Go, concorrência nativa);
- filtros de resposta (`-fc`, `-fs`, `-fw` — por código, tamanho, palavras);
- suporte a múltiplos pontos de fuzzing (`FUZZ`) na mesma requisição;
- modo recursivo.

---

## Cuidado
- Gera tráfego ativo e direto no alvo (diferente do ParamSpider, que é passivo) — usar só em escopo autorizado;
- wordlist ruim gera ruído (falso positivo) ou perde resultado (falso negativo).

---

## Observações pessoais
É o passo ativo que vem depois do ParamSpider — o ParamSpider levanta candidato via Wayback Machine, o ffuf confirma/expande via requisição direta. O Gobuster faz função parecida (mais simples, focado em diretório/DNS/vhost); o ffuf é mais versátil por fuzzar qualquer parte da requisição.

---

## GitHub
https://github.com/ffuf/ffuf

## Lembrete
Consultar documentação oficial sobre:
- filtros de resposta (`-fc`, `-fs`, `-fw`, `-mc`);
- fuzzing multi-ponto na mesma requisição;
- modo recursivo (`-recursion`).
