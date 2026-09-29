# Sergei Strelec WinPE

## Função
Disco de boot baseado em Windows PE (Windows 11/10) montado por terceiros, com um acervo grande de ferramentas já integradas.

Usado para:
- manutenção de computadores sem depender do Windows instalado;
- particionamento e recuperação de partições;
- backup e restauração de discos e partições;
- diagnóstico de hardware;
- recuperação de dados;
- instalação e reparo do Windows.

---

## Suporta
- boot UEFI e Legacy BIOS;
- ISO pronta para Ventoy (entra direto na biblioteca de ISOs);
- ambiente gráfico com menu de programas organizado por categoria.

---

## Usar quando
- O WinPE custom do toolkit não tiver a ferramenta necessária;
- Precisar de uma ferramenta proprietária de disco/backup que não faz parte do arsenal;
- Diagnóstico rápido em máquina de terceiros sem montar nada;
- Comparar comportamento com o WinPE custom durante a bateria de testes.

---

## Recursos importantes
- Centenas de programas pré-integrados (disco, backup, diagnóstico, rede, senhas);
- Suporte a rede e drivers adicionais no próprio ambiente;
- Atualizado com frequência pelo autor.

---

## Cuidado
- Baixar **somente** do site oficial e conferir o checksum publicado na página da versão. Há muitos sites espelhando a ISO (agregadores de download) — não usar.
- Integra ferramentas proprietárias de terceiros: **não serve de base para serviço cobrado** (licenciamento de terceiros).
- Antivírus costumam acusar falso positivo por causa de ferramentas de recuperação de senha incluídas.
- É imagem pronta, não receita: não é reproduzível a partir do git como o WinPE custom.

---

## Observações pessoais
Ferramenta de prateleira, não substitui o WinPE custom. Fica na biblioteca do Ventoy como plano B quando a receita própria não cobrir o caso.

---

## Site oficial
https://sergeistrelec.name/

## Lembrete
Consultar documentação oficial sobre:
- lista de programas da versão baixada;
- checksum publicado para a ISO;
- senha dos arquivos de download, quando houver.
