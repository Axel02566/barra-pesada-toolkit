# Git

## Função
Sistema de controle de versão distribuído.

Usado para:
- versionamento de código;
- rastreamento de alterações;
- colaboração;
- clonagem de repositórios;
- automação de scripts.

---

## Usar quando
- Clonar repositórios do GitHub;
- Versionar scripts e documentação;
- Atualizar ferramentas via repositório;
- Colaborar em projetos;
- Gerenciar histórico de alterações.

---

## Recursos importantes
- clone;
- pull/push;
- branch;
- commit;
- merge;
- log;
- diff.

---

## Comandos básicos
```bash
git clone https://github.com/usuario/repo
git pull
git status
git add .
git commit -m "mensagem"
git log
git diff
```

---

## Cuidado
- Não commitar dados sensíveis (senhas, tokens, chaves).
- Verificar `.gitignore` antes de commits.
- Repositórios públicos são visíveis para todos.

---

## Recomendações
- Configurar nome e email antes do uso:
```bash
git config --global user.name "Nome"
git config --global user.email "email@exemplo.com"
```
- Usar SSH em vez de HTTPS para repositórios frequentes.

---

## Observações pessoais
Mantido no toolkit principalmente para:
- clonar ferramentas diretamente do GitHub;
- atualizar repositórios de segurança;
- versionamento de scripts e documentação.

---

## Site oficial
https://git-scm.com/

## Documentação
https://git-scm.com/doc

## Lembrete
Consultar documentação oficial sobre:
- autenticação SSH;
- branching;
- resolução de conflitos;
- git stash.
