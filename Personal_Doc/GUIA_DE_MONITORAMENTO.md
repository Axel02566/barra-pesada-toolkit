# Guia de Monitoramento e Diagnóstico

Versão: Junho/2026

---

## Objetivo

Centralizar as principais ferramentas de monitoramento, diagnóstico e análise do Linux em um único documento de consulta rápida.

---

## Ferramentas

---

### HTOP

**Tipo:** Terminal (TUI)

**Função:** Monitor de processos.

**Equivalente:** Gerenciador de Tarefas do Windows.

**Exibe:**
- Uso de CPU e RAM
- Processos ativos e threads
- Consumo individual de recursos

**Comando:**
```bash
htop
```

**Instalação:**
```bash
sudo apt install htop
```

---

### BTOP++

**Tipo:** Terminal (TUI)

**Função:** Monitor avançado de sistema com interface moderna.

**Exibe:**
- CPU, RAM, Swap
- Disco, Rede
- Processos

**Comando:**
```bash
btop
```

**Instalação:**
```bash
sudo apt install btop
```

---

### NVTOP

**Tipo:** Terminal (TUI)

**Função:** Monitor de GPU.

**Exibe:**
- Uso da GPU e temperatura
- Memória de vídeo
- Processos utilizando GPU

**Comando:**
```bash
nvtop
```

**Instalação:**
```bash
sudo apt install nvtop
```

---

### CPU-X

**Tipo:** Interface gráfica (possui ícone)

**Função:** Identificação completa de hardware.

**Equivalente:** CPU-Z do Windows.

**Exibe:**
- CPU, RAM, Placa-mãe
- BIOS, Cache, Frequências

**Comando:**
```bash
cpu-x
```

---

### Hardinfo2

**Tipo:** Interface gráfica (possui ícone)

**Função:** Inventário completo do computador.

**Exibe:**
- Hardware e drivers
- Kernel
- Benchmarks

**Comando:**
```bash
hardinfo2
```

---

### LM-Sensors

**Tipo:** Terminal

**Função:** Monitoramento de sensores físicos.

**Exibe:**
- Temperatura da CPU e NVMe
- Ventoinhas e tensões

**Configuração inicial:**
```bash
sudo sensors-detect
```

**Consulta:**
```bash
sensors
```

**Instalação:**
```bash
sudo apt install lm-sensors
```

---

### Smartmontools

**Tipo:** Terminal

**Função:** Saúde de SSDs e HDs.

**Exibe:**
- Temperatura e horas de uso
- Desgaste e erros SMART

**Comando:**
```bash
sudo smartctl -a /dev/nvme0n1
```

**Instalação:**
```bash
sudo apt install smartmontools
```

---

### IOTOP

**Tipo:** Terminal

**Função:** Monitor de atividade de disco.

**Exibe:**
- Processos lendo e escrevendo no disco

**Comando:**
```bash
sudo iotop
```

**Instalação:**
```bash
sudo apt install iotop
```

---

### Powertop

**Tipo:** Terminal

**Função:** Análise de consumo energético. Ideal para notebooks.

**Exibe:**
- Consumo de energia
- Dispositivos ativos
- Processos gastando bateria

**Comando:**
```bash
sudo powertop
```

**Instalação:**
```bash
sudo apt install powertop
```

---

### GDU

**Tipo:** Terminal

**Função:** Analisador de uso de disco.

**Exibe:**
- Pastas e arquivos ocupando espaço

**Comando:**
```bash
gdu
```

**Instalação:**
```bash
sudo apt install gdu
```

---

### NCDU

**Tipo:** Terminal

**Função:** Alternativa clássica ao GDU.

**Comando:**
```bash
ncdu
```

**Instalação:**
```bash
sudo apt install ncdu
```

---

### Tmux

**Tipo:** Terminal

**Função:** Multiplexador de terminal.

**Permite:**
- Dividir terminal em painéis
- Manter processos rodando após desconexão
- Trabalho remoto mais robusto

**Comando:**
```bash
tmux
```

**Instalação:**
```bash
sudo apt install tmux
```

---

### Inxi

**Tipo:** Terminal

**Função:** Relatório completo do sistema.

**Comando recomendado:**
```bash
inxi -Fxxxrz
```

**Instalação:**
```bash
sudo apt install inxi
```

---

### Journalctl

**Tipo:** Terminal

**Função:** Visualizador de logs do systemd.

**Útil para investigar:**
- Boot, drivers, falhas de hardware, travamentos

**Comandos:**
```bash
# Boot atual
journalctl -b

# Boot anterior
journalctl -b -1

# Somente erros
journalctl -p err -b
```

---

### Dmesg

**Tipo:** Terminal

**Função:** Mensagens do kernel Linux.

**Útil para problemas de:**
- SSD, RAM, USB, PCIe

**Comandos:**
```bash
# Snapshot com timestamps
dmesg -T

# Tempo real
dmesg -Tw
```

---

### Stacer

**Tipo:** Interface gráfica (possui ícone)

**Função:** Dashboard visual do sistema.

**Exibe:**
- CPU, RAM, Disco, Rede, Processos

**Instalação:**
```bash
sudo apt install stacer
```

---

### Mission Center

**Tipo:** Interface gráfica (possui ícone)

**Função:** Gerenciador de tarefas moderno.

**Equivalente:** Gerenciador de Tarefas do Windows 11.

**Exibe:**
- CPU, RAM, Disco, Rede, GPU

---

### Netdata

**Tipo:** Dashboard Web

**Função:** Monitoramento completo em tempo real via navegador.

**Exibe:**
- CPU por núcleo, RAM, Swap, Disco, Rede
- Temperaturas e latência do SSD
- Containers

**Instalação:**
```bash
wget -O /tmp/netdata-kickstart.sh https://my-netdata.io/kickstart.sh
sh /tmp/netdata-kickstart.sh
```

**Acesso:**
```
http://localhost:19999
```

---

### LazyDocker

**Tipo:** Terminal (TUI)

**Função:** Interface visual para gerenciamento de containers Docker no terminal.

**Equivalente:** htop, mas focado exclusivamente em Docker.

**Permite:**
- Ver logs de cada container
- Reiniciar serviços
- Monitorar consumo de RAM por container

**Instalação:**
```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

---

### Timeshift

**Tipo:** Interface gráfica (possui ícone)

**Função:** Snapshots do sistema Linux.

**Equivalente:** Ponto de restauração do Windows.

**Permite:**
- Criar snapshots antes de atualizações ou experimentos
- Restaurar o sistema em minutos caso algo quebre
- Agendar snapshots automáticos

**Instalação:**
```bash
sudo apt install timeshift
```

---

### DBeaver Community

**Tipo:** Interface gráfica (possui ícone)

**Função:** Cliente universal para bancos de dados.

**Suporta:**
- PostgreSQL, MySQL, SQLite, MongoDB, MariaDB

**Instalação:**
```bash
sudo snap install dbeaver-ce
```

---

### Insomnia

**Tipo:** Interface gráfica (possui ícone)

**Função:** Cliente para teste de APIs REST e GraphQL.

**Alternativa:** Postman (mais pesado, requer conta).

**Útil para:**
- Testar endpoints de APIs locais
- Inspecionar requisições e respostas HTTP

**Instalação:**
```bash
sudo snap install insomnia
```

---

## Recomendações de uso

**Uso diário:**
- btop
- CPU-X
- Hardinfo2
- Mission Center

**Investigação de problemas:**
- journalctl
- dmesg
- smartctl
- sensors

**Armazenamento:**
- gdu
- ncdu

**Servidores e containers:**
- tmux
- netdata
- lazydocker

**Saúde de hardware:**
- lm-sensors
- smartmontools
- powertop

**Backup e proteção do sistema:**
- timeshift

**Desenvolvimento:**
- dbeaver-ce
- insomnia

---

## Prioridade de instalação

**Alta — instalar logo:**
- Timeshift *(proteção do sistema com dual-boot e módulos de kernel personalizados)*

**Média — instalar quando for usar:**
- LazyDocker *(quando Docker estiver em uso ativo)*
- DBeaver *(quando iniciar disciplina de BD no curso)*
- Insomnia *(quando começar a desenvolver ou testar APIs)*

**Baixa — avaliar necessidade:**
- Netdata *(poderoso, mas roda como serviço contínuo)*
- Stacer *(funcionalidade já coberta por btop e Mission Center)*

---

## Observações pessoais

Conjunto essencial para diagnóstico e manutenção no Linux.

Para investigação de falhas, a combinação mais eficiente é `journalctl -p err -b` + `dmesg -T` + `sensors` — cobre logs do sistema, mensagens do kernel e temperaturas em três comandos.

Smartmontools é indispensável antes de aposentar ou reutilizar qualquer disco.

Timeshift é a instalação mais urgente das recomendadas — com módulos de kernel personalizados (linuwu_sense), Secure Boot configurado manualmente e dual-boot ativo, o custo de uma reinstalação é alto. Criar um snapshot após qualquer configuração crítica elimina esse risco.
