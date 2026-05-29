# Project N.O.M.A.D.
## Node for Offline Media, Archives, and Data

## Função
Servidor de conhecimento offline e educacional auto-contido.

Permite:
- rodar Wikipedia offline;
- executar IA local via Ollama;
- acessar mapas offline;
- usar CyberChef para análise de dados;
- plataforma educacional via Kolibri;
- notas locais com suporte a Markdown;
- tudo acessível via browser, sem internet.

---

## Usar quando
- Ambiente sem acesso à internet;
- Laboratório offline isolado;
- Servidor local de conhecimento;
- Referência técnica offline;
- IA local sem dependência de nuvem.

---

## Recursos incluídos

| Ferramenta | Função |
|---|---|
| Kiwix | Wikipedia e referências offline |
| Ollama + Qdrant | IA local com RAG |
| Kolibri | Plataforma educacional Khan Academy |
| ProtoMaps | Mapas offline regionais |
| CyberChef | Criptografia, encoding, análise |
| FlatNotes | Notas locais em Markdown |

---

## Instalação
Debian/Ubuntu:
```bash
sudo apt-get update && \
sudo apt-get install -y curl && \
curl -fsSL https://raw.githubusercontent.com/Crosstalk-Solutions/project-nomad/refs/heads/main/install/install_nomad.sh \
  -o install_nomad.sh && \
sudo bash install_nomad.sh
```

Após instalação, acessar via browser:
```
http://localhost:8080
```

---

## Requisitos mínimos
- CPU: dual-core 2 GHz;
- RAM: 4 GB;
- Armazenamento: 5 GB livres;
- OS: Debian/Ubuntu;
- Internet apenas durante instalação inicial.

## Requisitos para IA local
- CPU: Ryzen 7 / Core i7 ou superior;
- RAM: 32 GB;
- GPU: NVIDIA RTX 3060 ou equivalente AMD;
- Armazenamento: 250 GB livres (SSD recomendado).

---

## Cuidado
- Não expor para a internet sem medidas de segurança.
- Não possui autenticação por padrão.
- Ferramentas de IA consomem recursos significativos.
- Internet necessária apenas na instalação inicial.

---

## Scripts úteis pós-instalação
Iniciar:
```bash
sudo bash /opt/project-nomad/start_nomad.sh
```
Parar:
```bash
sudo bash /opt/project-nomad/stop_nomad.sh
```
Atualizar:
```bash
sudo bash /opt/project-nomad/update_nomad.sh
```

---

## Observações pessoais
Ferramenta extremamente alinhada com a filosofia do toolkit:
- independência digital;
- laboratório offline;
- soberania de dados;
- zero telemetria por design.

Funciona como um "servidor de sobrevivência digital" portátil — especialmente útil em ambientes sem internet ou em situações de isolamento de rede.

No pendrive está armazenado como código fonte para instalação quando necessário.

---

## Plataforma
`[Linux]`

---

## GitHub
https://github.com/Crosstalk-Solutions/project-nomad

## Site oficial
https://www.projectnomad.us

## Documentação
https://www.projectnomad.us/install

## Lembrete
Consultar documentação oficial sobre:
- requisitos de hardware por caso de uso;
- configuração de IA local com Ollama;
- download de conteúdo Kiwix;
- segurança em rede local;
- atualização de containers.
