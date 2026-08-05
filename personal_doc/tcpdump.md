# tcpdump

## Função
Sniffer de pacotes via linha de comando.

Permite:
- capturar tráfego de rede em tempo real;
- filtrar por protocolo, host, porta (sintaxe BPF);
- salvar captura em arquivo `.pcap` pra analisar depois.

---

## Usar quando
- Capturar tráfego numa máquina sem interface gráfica (recuperação, SSH remoto, boot limitado);
- Diagnosticar problema de rede rapidamente via terminal;
- Gerar `.pcap` pra análise mais profunda depois no Wireshark.

---

## Recursos importantes
- Filtros BPF (`host`, `port`, `proto`, etc.);
- captura por interface específica (`-i`);
- output direto pra arquivo (`-w`);
- modo verboso (`-v`, `-vv`, `-vvv`).

---

## Cuidado
- Normalmente exige privilégio elevado (root/sudo);
- captura em rede compartilhada pode expor tráfego de terceiros — usar com responsabilidade.

---

## Observações pessoais
É o par leve do Wireshark que já está no toolkit — quando não dá pra abrir GUI (ambiente de recuperação, servidor remoto), o tcpdump resolve a captura e o `.pcap` gerado pode ser analisado com calma no Wireshark depois.

---

## Site oficial
https://www.tcpdump.org/

## GitHub
https://github.com/the-tcpdump-group/tcpdump

## Lembrete
Consultar documentação oficial sobre:
- sintaxe completa de filtros BPF;
- rotação de arquivo de captura (`-C`, `-W`);
- opções de snaplen (`-s`).
