# Sandboxie-Plus

## Função
Sandboxing leve no Windows — roda um programa isolado do sistema real sem precisar subir uma VM inteira.

Permite:
- isolar sistema de arquivos e registro do processo sandboxed;
- rodar múltiplas sandboxes simultâneas;
- limpar tudo que o programa fez com um clique, sem afetar o sistema real.

---

## Usar quando
- Fazer triagem rápida de um binário ou instalador suspeito;
- Testar software não confiável sem sujar o sistema;
- Abrir um anexo ou arquivo de origem duvidosa.

---

## Recursos importantes
- Isolamento de sistema de arquivos e registro;
- múltiplas sandboxes simultâneas e independentes;
- integração com o menu de contexto do Explorer.

---

## Cuidado
- Não é isolamento total como uma VM — malware sofisticado pode ter técnicas de fuga de sandbox;
- não substitui análise em VM isolada pra malware real (nesse caso, usar QEMU/VirtualBox).

---

## Observações pessoais
Cobre o caso de uso "quero só abrir isso rapidinho sem risco" — mais rápido que subir uma VM inteira, mas sem a segurança total dela. Entra como camada intermediária entre "rodar direto no sistema" e "VM completa".

---

## GitHub
https://github.com/sandboxie-plus/Sandboxie

## Lembrete
Consultar documentação oficial sobre:
- limites reais do isolamento;
- configuração de sandbox por aplicativo;
- diferenças pro Sandboxie clássico (descontinuado pela Sophos, agora mantido pela comunidade como Sandboxie-Plus).
