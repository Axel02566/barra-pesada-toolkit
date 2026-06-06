# Compressão e Arquivamento
## WinRAR + RAR Linux + 7-Zip

---

# Objetivo

Ferramentas utilizadas para:
- compactação;
- arquivamento;
- backup;
- transporte de arquivos;
- recuperação;
- criptografia;
- divisão de volumes;
- preservação de dados.

Extremamente importantes para:
- organização;
- redundância;
- documentação;
- armazenamento offline;
- data hoarding;
- recuperação de emergência.

---

# WinRAR

## Função
Interface gráfica para:
- arquivos RAR;
- ZIP;
- 7Z;
- TAR;
- ISO;
- CAB;
- entre outros.

Muito usado em Windows.

---

## Recursos importantes
- recuperação de arquivos;
- recovery record;
- split archives;
- AES-256;
- SFX;
- teste de integridade;
- compressão sólida.

---

## Usar quando
- Compactar arquivos;
- Criar backups;
- Dividir arquivos grandes;
- Proteger arquivos com senha;
- Transportar múltiplos arquivos.

---

## Cuidado
- Não esquecer senhas de arquivos criptografados.
- "Delete files after archiving" pode causar perda acidental.
- Recovery record NÃO substitui backup real.

---

## Observações pessoais
WinRAR continua extremamente relevante mesmo após décadas.

Muito útil para:
- backup;
- redundância;
- arquivamento portátil;
- recuperação parcial.

---

# rarlinux

## Função
Versão Linux/CLI do RAR.

Permite:
- criar;
- extrair;
- testar;
- automatizar arquivos compactados via terminal.

---

## Recursos importantes
- automação shell;
- integração com scripts;
- compressão RAR via CLI;
- recuperação;
- testes de integridade.

---

## Exemplos básicos
Criar arquivo:
```bash
rar a backup.rar pasta/
```
Extrair:
```bash
unrar x backup.rar
```
Testar integridade:
```bash
unrar t backup.rar
```

---

## Usar quando
- Scripts;
- automação;
- servidores;
- Linux;
- recuperação via terminal.

---

# 7-Zip

## Função
Compactador open-source extremamente eficiente.

Suporta:
- 7Z;
- ZIP;
- TAR;
- ISO;
- RAR (extração);
- GZIP;
- BZIP2;
- WIM;
- entre outros.

---

## Recursos importantes
- AES-256;
- alta taxa de compressão;
- multi-volume;
- self-extracting;
- benchmark integrado;
- integração shell.

---

## Usar quando
- Compactação máxima;
- Criptografia;
- Arquivos grandes;
- Backup offline;
- Distribuição de arquivos.

---

## Exemplo CLI

Compactar:
```bash
7z a arquivo.7z pasta/
```
Extrair:
```bash
7z x arquivo.7z
```
Criptografar:
```bash
7z a -p -mhe=on segredo.7z pasta/
```

---

## Explicação importante
`-mhe=on`

Oculta:
- nomes dos arquivos;
- estrutura interna do container.

Muito importante para privacidade.

---

## AES-256

### Observação importante
Senhas fortes + AES-256 tornam brute force extremamente inviável.

Especialmente com:
- senhas longas;
- aleatórias;
- alta entropia.

---

## Recomendações gerais
- SEMPRE testar arquivos após compactação;
- manter backup separado;
- validar integridade;
- evitar depender de um único arquivo crítico;
- documentar senhas importantes;
- usar hashes para arquivos sensíveis.

---

## Observações pessoais
Essas ferramentas praticamente formam:
- a espinha dorsal de backup portátil;
- arquivamento offline;
- preservação digital;
- redundância pessoal.

Especialmente úteis para:
- data hoarding;
- laboratórios offline;
- documentação;
- kits de recuperação;
- transporte seguro de arquivos.

---

## Sites oficiais

WinRAR:
https://www.win-rar.com/

RAR Linux:
https://www.rarlab.com/

7-Zip:
https://www.7-zip.org/

---

## Documentações

WinRAR:
https://www.win-rar.com/support.html

7-Zip:
https://7-zip.opensource.jp/chm/

---

## Lembrete
Consultar documentação oficial sobre:
- recovery record;
- recuperação de arquivos;
- criptografia;
- automação CLI;
- integridade;
- split volumes;
- limites dos formatos.
