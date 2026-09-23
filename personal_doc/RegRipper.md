# RegRipper

## Função
Ferramenta de análise forense do Registro do Windows, baseada em sistema de plugins que extrai artefatos conhecidos de hives.

Usado para:
- análise forense de registro do Windows;
- extração de artefatos de persistência e atividade de usuário;
- resposta a incidentes (IR);
- reconstrução de linha do tempo de uso do sistema.

---

## Suporta
- hives NTUSER.DAT, SAM, SYSTEM, SOFTWARE, SECURITY;
- análise offline (sem precisar de Windows rodando).

---

## Usar quando
- Investigar comprometimento em sistema Windows;
- Levantar histórico de execução (Run keys, UserAssist);
- Rastrear dispositivos USB conectados;
- Analisar shellbags e MRU lists;
- Buscar indícios de persistência de malware.

---

## Recursos importantes
- Sistema de plugins (cada plugin mira um artefato específico);
- Interface de linha de comando e GUI;
- Saída em texto plano, fácil de integrar em relatório;
- Comunidade ativa mantendo novos plugins.

---

## Cuidado
- Trabalhar sobre cópia dos hives, nunca sobre o sistema ativo.
- Resultado depende da cobertura dos plugins — não é exaustivo por padrão.
- Escrito em Perl — checar dependências antes de rodar offline.

---

## Observações pessoais
Fecha a lacuna de forense de registro que a categoria Reverse Engineering / Forensics não tinha — complementa TSK (disco) e volatility3 (memória), fechando o tripé clássico de DFIR.

---

## Site oficial
https://regripper.net/

## GitHub
https://github.com/keydet89/RegRipper3.0

## Lembrete
Consultar documentação oficial sobre:
- lista de plugins disponíveis;
- como escrever plugin próprio;
- diferença entre RegRipper 2.8 e 3.0.
