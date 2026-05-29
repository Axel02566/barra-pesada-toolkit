# Atalhos Windows (CAUTELA)

## Objetivo
Coleção de atalhos administrativos do Windows voltados para:
- manutenção;
- diagnóstico;
- troubleshooting;
- gerenciamento avançado;
- recuperação;
- análise de sistema.

A maior parte dessas ferramentas fornece acesso direto a funções internas do Windows normalmente escondidas do usuário comum.

---

# AVISO IMPORTANTE

## CUIDADO
Muitas dessas ferramentas possuem acesso:
- administrativo;
- estrutural;
- crítico;
- persistente;

e podem:
- quebrar inicialização;
- afetar drivers;
- alterar permissões;
- corromper serviços;
- causar perda de dados;
- comprometer estabilidade do sistema.

---

# Ferramentas

---

## Component Services
### Executável
`dcomcnfg`

### Função
Gerenciamento de:
- COM/DCOM;
- serviços distribuídos;
- permissões avançadas;
- aplicações de sistema.

### Usar quando
- troubleshooting de permissões;
- problemas de COM/DCOM;
- serviços corporativos;
- integração de aplicações.

### Cuidado
Configurações incorretas podem:
- quebrar aplicações;
- causar falhas de autenticação;
- gerar erros persistentes no Windows.

---

## Computer Management
### Executável
`compmgmt.msc`

### Função
Console central de administração.

Inclui:
- gerenciamento de disco;
- eventos;
- usuários;
- serviços;
- dispositivos;
- tarefas agendadas.

### Observação
Uma das ferramentas administrativas mais importantes do Windows.

---

## dfrgui
### Executável
`dfrgui`

### Função
Desfragmentador e otimizador de unidades.

### Observação
- HDD → desfragmentação;
- SSD → otimização/TRIM.

### Cuidado
Não realizar desfragmentação manual agressiva em SSD.

---

## Disk Cleanup
### Executável
`cleanmgr`

### Função
Limpeza de:
- temporários;
- cache;
- logs;
- Windows Update antigo.

### Observação
Útil para manutenção leve e ganho de espaço.

---

## Event Viewer
### Executável
`eventvwr.msc`

### Função
Visualizador de logs do Windows.

### Usar para
- BSOD;
- erros de driver;
- falhas de boot;
- análise de sistema;
- troubleshooting.

### Observação
Ferramenta essencial para diagnóstico avançado.

---

## iSCSI Initiator
### Executável
`iscsicpl`

### Função
Gerenciamento de conexões iSCSI.

### Usar quando
- storage remoto;
- SAN;
- virtualização;
- ambientes corporativos.

### Observação
Pouco usado em ambiente doméstico.

---

## Memory Diagnostics Tool
### Executável
`mdsched`

### Função
Diagnóstico básico de memória RAM.

### Observação
Menos completo que:
- MemTest86;
- Testes avançados de RAM.

Mas útil para verificação rápida.

---

## ODBC Data Sources (32-bit / 64-bit)
### Executáveis
`odbcad32`

### Função
Gerenciamento de drivers e conexões ODBC.

### Usar quando
- bancos de dados;
- aplicações legadas;
- integração SQL;
- software corporativo.

### Observação
Importante distinguir:
- versão 32-bit;
- versão 64-bit.

---

## Performance Monitor
### Executável
`perfmon`

### Função
Monitoramento avançado de:
- CPU;
- RAM;
- disco;
- rede;
- processos;
- performance geral.

### Observação
Extremamente poderoso para troubleshooting profundo.

---

## RecoveryDrive
### Executável
`RecoveryDrive.exe`

### Função
Criação de unidade de recuperação do Windows.

### Usar quando
- recuperação de boot;
- reparo do sistema;
- troubleshooting offline.

---

## Registry Editor
### Executável
`regedit`

### Função
Editor do Registro do Windows.

### Cuidado EXTREMO
Alterações incorretas podem:
- inutilizar o Windows;
- quebrar drivers;
- impedir boot;
- causar corrupção de sistema.

### Recomendação
Sempre criar backup/exportação antes de alterar algo.

---

## Resource Monitor
### Executável
`resmon`

### Função
Monitoramento detalhado de:
- CPU;
- RAM;
- disco;
- rede;
- processos.

### Observação
Complementa:
- Task Manager;
- Process Explorer;
- Performance Monitor.

---

## services
### Executável
`services.msc`

### Função
Gerenciamento de serviços do Windows.

### Permite
- iniciar;
- parar;
- desativar;
- automatizar serviços.

### Cuidado
Desativar serviços errados pode:
- quebrar funcionalidades;
- impedir login;
- causar falhas de boot.

---

## System Configuration
### Executável
`msconfig`

### Função
Configuração de:
- boot;
- inicialização;
- serviços;
- diagnóstico.

### Usar quando
- troubleshooting;
- boot limpo;
- análise de conflitos.

---

## System Information
### Executável
`msinfo32`

### Função
Informações completas do sistema.

Inclui:
- hardware;
- drivers;
- BIOS;
- IRQs;
- memória;
- componentes.

### Observação
Excelente para inventário rápido.

---

## Task Scheduler
### Executável
`taskschd.msc`

### Função
Gerenciamento de tarefas automáticas.

### Permite
- automação;
- scripts;
- execução programada;
- persistência.

### Cuidado
Malwares frequentemente utilizam tarefas agendadas.

---

## Windows Defender Firewall with Advanced Security
### Executável
`wf.msc`

### Função
Configuração avançada do firewall do Windows.

### Permite
- regras inbound/outbound;
- filtros;
- bloqueios específicos;
- auditoria de tráfego.

### Observação
Muito mais poderoso que o painel simples do firewall.

---

# GPEDIT (não presente)

## Executável
`gpedit.msc`

## Função
Editor de Política de Grupo Local.

Permite:
- alterar políticas do Windows;
- controlar comportamento do sistema;
- configurar segurança;
- restringir recursos;
- automatizar regras administrativas.

---

## Usar quando
- hardening;
- privacy;
- tuning corporativo;
- controle avançado do Windows.

---

## Observação importante
Não disponível oficialmente em:
- Windows Home;
- algumas versões simplificadas.

---

## Cuidado
Configurações incorretas podem:
- quebrar atualizações;
- impedir login;
- desativar recursos importantes;
- causar conflitos de políticas.

---

# Filosofia da pasta

Esta pasta existe para:
- acesso rápido;
- manutenção;
- recuperação;
- troubleshooting;
- administração avançada.

Ela funciona como:
> "painel de controle avançado portátil do Windows"

---

# Recomendação pessoal

Antes de alterar:
- registro;
- serviços;
- políticas;
- boot;

sempre:
- criar backup;
- exportar configuração;
- documentar alterações;
- testar gradualmente.

---

# Ferramentas mais perigosas da pasta

Maior risco de dano ao sistema:
- Registry Editor
- services.msc
- gpedit.msc
- Task Scheduler
- Firewall Advanced Security
- Component Services

---

# Observação final

Conhecimento administrativo do Windows vale mais do que:
- “otimizadores milagrosos”;
- tweaks aleatórios;
- scripts copiados sem entender.

Entender essas ferramentas transforma troubleshooting em diagnóstico real.