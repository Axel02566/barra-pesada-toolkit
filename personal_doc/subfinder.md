# subfinder

## Função
Ferramenta de enumeração passiva de subdomínio, da ProjectDiscovery.

Permite:
- levantar subdomínios de um alvo consultando fontes passivas;
- encadear direto com o resto do ecossistema ProjectDiscovery (httpx, nuclei).

---

## Usar quando
- Levantar subdomínios de um alvo antes de qualquer scan ativo;
- Complementar o Sherlock no lado OSINT — Sherlock cobre usuário/pessoa, subfinder cobre infraestrutura.

---

## Recursos importantes
- Múltiplas fontes passivas (certificate transparency, APIs públicas);
- integração nativa com httpx e nuclei (mesma família de ferramentas);
- output limpo, pronto pra encadear em pipeline com outras ferramentas.

---

## Cuidado
- Cobertura depende das fontes configuradas — algumas exigem chave de API própria pra resultado completo;
- é só enumeração — não confirma se o subdomínio está de fato ativo (precisa de um httpx/ffuf depois pra validar).

---

## Observações pessoais
theHarvester é uma alternativa mais antiga e mais ampla (também pega e-mail, não só subdomínio) — subfinder é mais focado e mais rápido, e já pensado pra encadear com o ffuf.

---

## GitHub
https://github.com/projectdiscovery/subfinder

## Lembrete
Consultar documentação oficial sobre:
- configuração de chaves de API por fonte;
- integração com httpx pra validar subdomínios ativos;
- formatos de output.
