# The Sleuth Kit (TSK)

## Função
Coleção de ferramentas de linha de comando e biblioteca C para investigação forense de imagens de disco e sistemas de arquivos.

Usado para:
- análise forense de disco;
- recuperação de arquivos apagados a partir da estrutura do filesystem;
- timeline de atividade do sistema de arquivos;
- extração de metadados (inode/MFT);
- análise de estrutura de partição.

---

## Suporta
- NTFS;
- FAT/exFAT;
- ext2/ext3/ext4;
- HFS+;
- ISO 9660;
- UFS.

---

## Usar quando
- Analisar imagem de disco (dd, E01, raw);
- Reconstruir timeline de eventos no sistema de arquivos;
- Recuperar arquivos apagados via estrutura do filesystem (não apenas carving);
- Investigar incidente ou comprometimento;
- Validar integridade de evidência forense.

---

## Recursos importantes
- fls (listagem de arquivos, incluindo apagados);
- icat (extração de conteúdo por inode);
- mactime (timeline de MAC times);
- tsk_recover (recuperação em lote);
- Autopsy (frontend gráfico, projeto irmão).

---

## Cuidado
- Trabalhar sempre sobre uma cópia/imagem, nunca sobre o disco original.
- Preservar cadeia de custódia (hash antes e depois da análise).
- Ferramenta de análise, não de wipe — mas manipular disco exige atenção redobrada.

---

## Observações pessoais
Padrão-ouro open source em forense de filesystem. Preenche a lacuna de disco que a categoria Reverse Engineering / Forensics não tinha — volatility3 cobre memória, TSK cobre disco.

---

## Site oficial
https://www.sleuthkit.org/

## GitHub
https://github.com/sleuthkit/sleuthkit

## Lembrete
Consultar documentação oficial sobre:
- formatos de imagem suportados (raw, E01, AFF);
- integração com Autopsy;
- mactime e construção de timeline.
