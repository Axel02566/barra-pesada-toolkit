# Netcat (ncat)

## Função
Canivete suíço de rede — leitura e escrita de dados brutos via TCP/UDP.

Permite:
- testar conectividade de porta manualmente;
- transferir arquivo rápido sem subir servidor dedicado;
- debugar serviço de rede na mão;
- criar listener simples pra teste em laboratório controlado.

---

## Usar quando
- Confirmar se uma porta está de fato aberta e respondendo;
- Diagnosticar serviço de rede sem ferramenta gráfica disponível;
- Transferência rápida de arquivo entre duas máquinas na mesma rede;
- Estudo de protocolo de rede na prática.

---

## Recursos importantes
- Modo listener (`-l`);
- conexão simples TCP/UDP;
- redirecionamento de I/O;
- `ncat` (do pacote Nmap) adiciona SSL, proxy e IPv6 que o netcat clássico não tem.

---

## Cuidado
- Shell reverso/bind sem criptografia fica visível em qualquer captura de tráfego;
- usar apenas em ambiente próprio ou expressamente autorizado;
- existem várias implementações (GNU netcat, OpenBSD nc, ncat) com flags diferentes entre si.

---

## Observações pessoais
Complementa o Nmap que já está no toolkit — o Nmap identifica a porta aberta, o netcat/ncat interage com ela manualmente depois.

---

## Site oficial
ncat (via Nmap): https://nmap.org/ncat/

## Lembrete
Consultar documentação oficial sobre:
- diferenças entre implementações (GNU / OpenBSD / ncat);
- suporte a SSL e proxy no ncat;
- uso combinado com redirecionamento de shell.
