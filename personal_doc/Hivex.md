# Hivex

## Função
Biblioteca C (com bindings para Perl, Python, Ruby, OCaml) para leitura e escrita de hives do Registro do Windows, sem depender de uma instalação Windows ativa.

Usado para:
- acesso programático e de baixo nível a hives de registro;
- extração/edição de valores de registro em imagens offline (ex: VM, disco montado);
- conversão entre hive binário e formato .reg;
- construção de tooling forense próprio.

---

## Suporta
- leitura e escrita de hives NT (mesmo formato de NTUSER.DAT, SYSTEM, SOFTWARE etc.);
- inclui hivexregedit (edição via .reg) e hivexml (exportação em XML).

---

## Usar quando
- Precisar de acesso bruto a um hive sem os plugins prontos do RegRipper;
- Escrever script próprio para extrair/alterar dados de registro offline;
- Montar imagem de disco (ex: via libguestfs) e mexer no registro sem bootar o Windows;
- Automatizar edição de configuração em VM offline.

---

## Recursos importantes
- API em C, com bindings de alto nível;
- hivexregedit (import/export .reg);
- hivexsh (shell interativo tipo regedit);
- Parte do projeto libguestfs (Red Hat).

---

## Cuidado
- Não tem "inteligência forense" embutida — é acesso bruto ao formato, não análise de artefato.
- Escrita em hive é operação sensível — sempre trabalhar em cópia.
- Ferramenta complementar, não substitui RegRipper para análise de artefato conhecido.

---

## Observações pessoais
Complemento de baixo nível ao RegRipper. Útil se decidir escrever tooling próprio de parsing de hive; opcional se o uso for só análise forense padrão.

---

## Site oficial
https://libguestfs.org/hivex.3.html

## GitHub
https://github.com/libguestfs/hivex

## Lembrete
Consultar documentação oficial sobre:
- API C vs bindings de linguagem;
- hivexregedit e hivexsh;
- integração com libguestfs para montagem offline.
