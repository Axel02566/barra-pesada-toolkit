# Autoruns

## Função
Ferramenta avançada da Sysinternals para análise de persistência no Windows.

Mostra:
- inicialização automática;
- serviços;
- drivers;
- scheduled tasks;
- shell extensions;
- DLLs;
- logon entries;
- browser helpers;
- AppInit;
- Winlogon;
- codecs;
- e diversos pontos internos do sistema.

---

## Usar quando
- Diagnosticar malware;
- Verificar persistência suspeita;
- Otimizar boot;
- Remover startup desnecessário;
- Auditar sistema.

---

## Recursos importantes
- Hide Microsoft Entries;
- Verify Code Signatures;
- VirusTotal integration;
- filtros avançados.

---

## Cuidado
- Desativar item errado pode quebrar:
  - drivers;
  - antivírus;
  - áudio;
  - GPU;
  - boot.

- NÃO sair desabilitando tudo aleatoriamente.

---

## Fluxo recomendado
1. Hide Microsoft Entries;
2. Verify Signatures;
3. Procurar entradas desconhecidas;
4. Pesquisar antes de remover.

---

## Observações pessoais
Ferramenta extremamente poderosa para:
- manutenção;
- análise;
- persistência;
- troubleshooting avançado.

Praticamente um raio-X da inicialização do Windows.

---

## Site oficial
https://learn.microsoft.com/sysinternals/downloads/autoruns

## Lembrete
Consultar documentação oficial antes de:
- remover drivers;
- mexer em Winlogon;
- alterar serviços críticos.