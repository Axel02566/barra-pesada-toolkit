# SQLMap

## Função
Ferramenta automatizada de detecção e exploração de SQL injection.

Permite:
- detectar automaticamente técnica de injeção (boolean, time-based, union, etc.);
- explorar a vulnerabilidade encontrada;
- extrair dados de bancos suportados.

---

## Usar quando
- Testar um parâmetro suspeito de injeção (ex: levantado pelo ParamSpider/ffuf) em pentest web autorizado;
- Validar formalmente uma vulnerabilidade antes de reportar.

---

## Recursos importantes
- Detecção automática de técnica de injeção;
- suporte a múltiplos SGBDs (MySQL, PostgreSQL, MSSQL, Oracle, SQLite, etc.);
- extração e dump de dados;
- níveis configuráveis de risco e profundidade de teste (`--risk`, `--level`).

---

## Cuidado
- Ferramenta de exploração ativa e de alto impacto — uso sem autorização explícita é ilegal;
- pode gerar carga pesada no banco alvo;
- usar apenas em ambiente de teste ou expressamente autorizado.

---

## Observações pessoais
Fecha o pipeline recon → confirmação que ParamSpider e ffuf abrem — sem ele, os parâmetros descobertos ficam sem próximo passo natural dentro do toolkit.

---

## GitHub
https://github.com/sqlmapproject/sqlmap

## Lembrete
Consultar documentação oficial sobre:
- níveis de risco e profundidade de teste (`--risk`, `--level`);
- tamper scripts (evasão de WAF);
- opções de extração/dump de dados.
