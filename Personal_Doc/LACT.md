# LACT (Linux GPU Control Application)

## Função
Ferramenta de configuração e monitoramento de GPU para Linux.

Suporta:
- AMD;
- Nvidia (driver proprietário);
- Intel.

Permite:
- controle de fan curve;
- power cap;
- overclock e undervolt;
- monitoramento em tempo real;
- perfis automáticos por processo;
- exportação de dados históricos em CSV.

---

## Usar quando
- Configurar GPU no Linux;
- Monitorar temperatura e clock em tempo real;
- Criar fan curves customizadas;
- Ajustar power limits;
- Substituir MSI Afterburner no Linux.

---

## Recursos importantes
- GPU info detalhada (VRAM, VBIOS, Resizable BAR);
- monitoramento histórico com gráficos;
- fan curve customizada (AMD/Nvidia);
- power cap configurável;
- overclock de GPU/VRAM;
- undervolt via voltage offset;
- perfis automáticos por processo ou GameMode;
- CLI disponível;
- serviço systemd independente de sessão gráfica.

---

## Instalação
Debian/Ubuntu:
```bash
# Baixar .deb em:
# https://github.com/ilya-zlobintsev/LACT/releases/latest
sudo dpkg -i lact_*.deb
```

Habilitar o serviço:
```bash
sudo systemctl enable --now lactd
```

---

## Cuidado
- Overclock pode causar instabilidade.
- Nvidia requer driver proprietário com CUDA instalado.
- Em notebooks com Optimus/hybrid graphics o controle pode ser limitado.
- Sempre testar estabilidade após alterações.

---

## Recomendações
- Combinar com FurMark para validar estabilidade após ajustes;
- Usar perfis automáticos para alternar entre modos de uso;
- Fazer backup do config antes de alterações agressivas.

---

## Observações pessoais
Preenche a lacuna de controle de GPU no lado Linux do toolkit.

No Acer com GPU Nvidia dedicada + Intel integrada (Optimus):
- controle pode ser parcial dependendo do driver;
- CUDA já disponível no pendrive como dependência;
- útil principalmente para monitoramento e fan curve.

Equivalente Linux ao MSI Afterburner, sem o histórico problemático.

---

## Plataforma
`[Linux]`

---

## GitHub
https://github.com/ilya-zlobintsev/LACT

## Releases
https://github.com/ilya-zlobintsev/LACT/releases/latest

## Wiki
https://github.com/ilya-zlobintsev/LACT/wiki

## Lembrete
Consultar documentação oficial sobre:
- suporte ao hardware específico;
- configuração com Optimus/hybrid GPU;
- perfis automáticos;
- recuperação de overclock ruim.
