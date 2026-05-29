# Hardinfo2

## Função
Ferramenta de informações de hardware para Linux.

Permite visualizar:
- CPU;
- RAM;
- GPU;
- discos;
- sensores;
- kernel;
- módulos;
- benchmark simples.

Fork moderno do HardInfo clássico.

---

## Usar quando
- Diagnóstico em Linux;
- Verificar hardware reconhecido;
- Inventário do sistema;
- Benchmark leve;
- Troubleshooting rápido.

---

## Recursos importantes
- system profiler;
- benchmark básico;
- informações do kernel;
- módulos carregados;
- sensores do sistema;
- resumo completo do hardware.

---

## Cuidado
- Benchmarks integrados são simples.
- Não substituir ferramentas especializadas.
- Alguns sensores dependem do lm-sensors.

---

## Dependências comuns
- lm-sensors;
- pciutils;
- usbutils;
- mesa-utils.

---

## Recomendações
Executar antes:
```bash
sudo sensors-detect
```

E instalar:
```bash
sudo apt install lm-sensors
```

---

## Observações pessoais
Excelente alternativa Linux para:
- CPU-Z;
- Speccy;
- HWMonitor.

Muito útil em:
- distros live;
- troubleshooting;
- inventário rápido;
- notebooks.

---

## GitHub
https://github.com/hardinfo2/hardinfo2

---

## Documentação
https://github.com/hardinfo2/hardinfo2/wiki

---

## Lembrete
Consultar documentação oficial sobre:
- suporte a sensores;
- benchmark integrado;
- dependências opcionais.
