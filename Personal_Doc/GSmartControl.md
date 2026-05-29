# GSmartControl

## Função
Interface gráfica para smartctl — ferramenta de leitura e análise de dados SMART de HDDs e SSDs.

Permite:
- inspecionar saúde de discos;
- visualizar atributos SMART;
- executar testes de disco;
- identificar anomalias e falhas.

Equivalente Linux ao CrystalDiskInfo.

---

## Usar quando
- Verificar saúde de disco em Linux;
- Diagnosticar HDD antigo;
- Conferir temperatura de SSD NVMe;
- Validar disco recém comprado;
- Monitorar desgaste em ambiente Linux.

---

## Recursos importantes
- visualização completa de atributos SMART;
- destaque automático de anomalias;
- testes de disco integrados (short, long, conveyance);
- tooltips explicativos para cada atributo;
- suporte a HDD, SSD e NVMe;
- coleta automática offline de dados.

---

## Testes disponíveis
- **Short** → verificação rápida (~2 min);
- **Long** → verificação completa (pode demorar horas);
- **Conveyance** → verifica danos de transporte.

---

## Cuidado
- Requer privilégios de root para acesso completo.
- Alguns atributos variam por fabricante — não entrar em pânico por valores altos sem contexto.
- Não substitui backup em caso de disco degradado.

---

## Dependência
Requer o pacote `smartmontools` instalado:
```bash
sudo apt install smartmontools
```

---

## Observações pessoais
Complemento essencial ao Hardinfo2 no lado Linux.

Preenche a lacuna que o CrystalDiskInfo deixa em ambientes Linux:
- CrystalDiskInfo → Windows;
- GSmartControl → Linux.

---

## Plataforma
`[Linux / Windows]`

---

## Site oficial
https://gsmartcontrol.shaduri.dev/

## GitHub
https://github.com/ashaduri/gsmartcontrol

## Lembrete
Consultar documentação oficial sobre:
- interpretação de atributos SMART;
- testes long vs short;
- uso com NVMe;
- execução como root.
