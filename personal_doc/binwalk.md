# binwalk

## Função
Ferramenta de análise de firmware e imagens binárias.

Permite:
- identificar assinaturas de arquivo embutidas em um blob binário;
- extrair filesystems, headers e certificados embutidos;
- analisar entropia pra localizar dados comprimidos/criptografados;
- diseccionar dumps de firmware/flash/EEPROM.

---

## Usar quando
- Analisar firmware desconhecido de dispositivo embarcado/IoT;
- Extrair conteúdo de uma imagem de flash/EEPROM;
- Investigar um binário suspeito com dados embutidos;
- Triagem inicial antes de RE mais profunda (Ghidra, x64dbg).

---

## Recursos importantes
- Signature scanning (magic bytes);
- extração automática recursiva;
- análise de entropia;
- suporte a diversos formatos de compressão e filesystem;
- versão v3 reescrita em Rust (ReFirmLabs) — binário standalone, mais portátil que a v2/Python.

---

## Cuidado
- Extração de alguns formatos (squashfs, jffs2, etc.) ainda pode depender de ferramentas externas, dependendo da versão usada;
- assinatura não é infalível — falsos positivos existem;
- firmware/binário de origem desconhecida deve ser analisado em ambiente isolado.

---

## Observações pessoais
Complementa Ghidra/x64dbg/DIE quando o alvo é uma imagem binária bruta (firmware, dump de flash) em vez de um executável isolado — entra antes deles na cadeia de análise.

---

## GitHub
https://github.com/ReFirmLabs/binwalk

## Lembrete
Consultar documentação oficial sobre:
- extractors e módulos disponíveis;
- assinaturas customizadas;
- diferenças entre a versão legada (Python) e a v3 (Rust).
