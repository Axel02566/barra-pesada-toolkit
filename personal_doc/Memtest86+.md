# Memtest86+

## Função
Testador de memória RAM open source (GPL v2), executado direto no boot, sem sistema operacional.

Detecta:
- erro físico;
- instabilidade;
- falha intermitente de módulo ou controlador de memória.

---

## Suporta
- boot UEFI e Legacy BIOS;
- ISO (entra direto na biblioteca do Ventoy);
- binário .efi avulso (pode ir numa pasta própria do ESP, chamado pelo roteador).

---

## Usar quando
- Suspeitar de RAM defeituosa em máquina que nem boota o sistema;
- Validar RAM nova ou upgrade;
- Confirmar resultado do MemTest86 com uma segunda ferramenta independente.

---

## Recursos importantes
- Testa praticamente toda a RAM (não disputa memória com um sistema operacional);
- Suporte a múltiplos núcleos;
- Código aberto: sem restrição de licença para uso em serviço.

---

## Cuidado
- Não confundir com o **MemTest86** (PassMark): são projetos diferentes, de origem comum.
- Processo pode demorar horas; 1 passe completo no mínimo.
- XMP/EXPO instável pode gerar erro que some com a memória em configuração padrão.

---

## Observações pessoais
Redundância livre para o MemTest86. Se um dos dois falhar em bootar numa máquina, o outro cobre.

---

## Site oficial
https://www.memtest.org/

## GitHub
https://github.com/memtest86plus/memtest86plus

## Lembrete
Consultar documentação oficial sobre:
- diferença entre ISO, imagem USB e binários avulsos;
- opções de linha de comando no boot;
- interpretação dos testes que falharem.
