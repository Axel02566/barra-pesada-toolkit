# VirtualBox

## Função
Hipervisor tipo 2 para virtualização de sistemas operacionais.

Permite:
- rodar múltiplos sistemas operacionais;
- criar ambientes isolados;
- testar software;
- simular redes;
- análise de malware em sandbox.

---

## Usar quando
- Testes de software;
- Laboratório de segurança;
- Instalação de sistemas alternativos;
- Isolamento de risco;
- Ambientes de desenvolvimento.

---

## Recursos importantes
- snapshots;
- snapshots rollback;
- redes NAT/bridge/host-only;
- USB passthrough;
- shared folders;
- suporte a ISO boot;
- EFI/BIOS virtual.

---

## Cuidado
- desempenho depende do hardware host;
- má configuração pode expor host à VM;
- drivers guest necessários para integração completa.

---

## Recomendações
- usar snapshots antes de testes perigosos;
- separar VMs por propósito;
- manter ISO de recuperação;
- não compartilhar pastas sensíveis sem controle.

---

## Observações pessoais
Ferramenta essencial para:
- segurança;
- testes;
- laboratório;
- isolamento de execução.

---

## Site oficial
https://www.virtualbox.org/

## Documentação
https://www.virtualbox.org/wiki/Documentation

## Lembrete
Consultar documentação sobre:
- networking modes;
- snapshots;
- guest additions;
- EFI em VMs.