# Ventoy

## Função
Ferramenta para criação de pendrive bootável multiboot.

Permite:
- armazenar múltiplas ISOs;
- bootar Linux;
- bootar Windows;
- ferramentas de recuperação;
- ambientes live;
- utilitários de diagnóstico.

Não requer regravar o pendrive a cada ISO nova.

---

## Usar quando
- Criar ambiente de recuperação;
- Instalar Windows/Linux;
- Bootar ferramentas de manutenção;
- Executar utilitários offline;
- Recuperar sistemas quebrados.

---

## Estrutura
Ventoy cria:
- partição de boot;
- partição de armazenamento.

As ISOs podem ser copiadas normalmente.

---

## Problemas comuns
### Windows quebrando Secure Boot
- SBAT revocations;
- MOK apagada;
- entrada EFI removida.

### Pendrive não aparece
- EFI corrompida;
- boot order alterada;
- Secure Boot bloqueando.

---

## Cuidado
- Não formatar o pendrive sem backup.
- Atualizar Ventoy periodicamente.
- Backup das ISOs importantes.
- Alguns antivírus acusam falso positivo.

---

## Observações pessoais
No meu caso:
- Windows já removeu entradas EFI;
- Secure Boot já bloqueou boot;
- documentação própria de recuperação criada.

---

## Verificações importantes
- efibootmgr
- mokutil
- badblocks
- Secure Boot state

---

## Site oficial
https://www.ventoy.net/

## GitHub
https://github.com/ventoy/Ventoy

## Lembrete
Consultar documentação oficial em caso de:
- Secure Boot;
- atualização;
- problemas EFI;
- boot quebrado.