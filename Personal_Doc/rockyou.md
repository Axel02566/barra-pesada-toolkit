# rockyou.txt

## Função
Wordlist clássica para auditoria e testes de senhas.

Contém:
- milhões de senhas reais vazadas;
- senhas comuns;
- padrões frequentes;
- base para ataques de dicionário.

---

## Usar quando
- Auditoria autorizada de senhas;
- Laboratório;
- Testes com Hashcat ou John the Ripper;
- Estudo de segurança.

---

## Recursos importantes
- cobertura ampla de senhas comuns;
- compatível com Hashcat e John the Ripper;
- referência padrão da indústria para pentest.

---

## Cuidado
- Uso não autorizado pode ser ilegal.
- Arquivo contém dados de vazamento real.
- Não usar contra sistemas sem permissão explícita.

---

## Recomendações
- Usar apenas em laboratório controlado;
- Combinar com regras do Hashcat para maior cobertura;
- Manter comprimido quando não estiver em uso.

---

## Uso típico com Hashcat
```bash
hashcat -a 0 -m 0 hashes.txt rockyou.txt
```

## Uso típico com John the Ripper
```bash
john --wordlist=rockyou.txt hashes.txt
```

---

## Observações pessoais
Mantida no toolkit como:
- referência de wordlist padrão;
- recurso para laboratório;
- complemento ao Hashcat e John the Ripper.

Praticamente a wordlist mais famosa do ecossistema de segurança.

---

## Origem
Vazamento do banco de dados RockYou (2009).
Disponível publicamente em repositórios de segurança e distribuições como Kali Linux.

## Lembrete
Consultar documentação do Hashcat e John the Ripper sobre:
- rule engine;
- combinação com máscaras;
- otimização de performance.
