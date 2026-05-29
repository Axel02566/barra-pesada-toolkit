# Nmap

## Função
Scanner de rede e auditoria.

Usado para:
- descobrir hosts;
- portas;
- serviços;
- versões;
- sistemas operacionais.

---

## Usar quando
- Auditoria autorizada;
- Laboratório;
- Diagnóstico de rede.

---

## Recursos importantes
- port scan;
- service detection;
- OS detection;
- NSE scripts.

---

## Exemplos básicos
```bash
nmap alvo
nmap -sV alvo
nmap -A alvo
```

---

## Cuidado
- Pode disparar alertas IDS/IPS.
- Alguns scans são considerados agressivos.

---

## Observações pessoais
Praticamente ferramenta obrigatória para redes e segurança.

---

## Site oficial
https://nmap.org/

---

## Documentação
https://nmap.org/docs.html

---

## Lembrete
Consultar documentação oficial sobre:
- NSE;
- scan types;
- timing;
- stealth scanning.
