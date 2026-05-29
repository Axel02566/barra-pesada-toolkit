# GOverlay

## Função
Interface gráfica para configuração do MangoHud, vkBasalt e OptiScaler no Linux.

Permite:
- configurar o MangoHud visualmente sem editar arquivos;
- ajustar overlay de monitoramento;
- configurar efeitos de pós-processamento via vkBasalt;
- gerenciar OptiScaler para upscaling e frame generation.

---

## Usar quando
- Configurar o MangoHud sem editar o arquivo .conf manualmente;
- Ajustar posição, cores e sensores do overlay;
- Configurar vkBasalt para efeitos visuais em jogos Vulkan;
- Gerenciar perfis de overlay de forma visual.

---

## Recursos importantes
- interface gráfica completa para MangoHud;
- preview em tempo real das configurações;
- configuração de vkBasalt;
- integração com OptiScaler;
- suporte a AppImage e Flatpak;
- disponível nos repositórios oficiais de várias distros.

---

## Dependências obrigatórias
- MangoHud;
- vkBasalt;
- mesa-demos;
- vulkan-tools;
- git;
- qt6pas.

---

## Instalação
Ubuntu/Debian (via AppImage recomendado):
```bash
# Baixar AppImage em:
# https://github.com/benjamimgois/goverlay/releases/latest
chmod +x Goverlay_*.AppImage
./Goverlay_*.AppImage
```

Arch Linux:
```bash
sudo pacman -S goverlay
```

Flatpak:
```bash
flatpak install flathub io.github.benjamimgois.goverlay
```

---

## Cuidado
- Requer MangoHud instalado para funcionar.
- Fedora/Debian/Ubuntu têm versões desatualizadas nos repositórios oficiais — preferir AppImage ou Flatpak.
- Alterações no overlay são aplicadas globalmente a todos os jogos por padrão.

---

## Recomendações
- Usar AppImage para maior compatibilidade entre distros;
- Combinar com LACT para controle completo de GPU + overlay;
- Testar configurações em jogo antes de fixar o perfil.

---

## Observações pessoais
Complemento essencial ao MangoHud no toolkit Linux.

Elimina a necessidade de editar o MangoHud.conf manualmente — especialmente útil em campo ou em instalações novas onde configurar tudo na mão seria demorado.

Trio recomendado para Linux gaming/benchmark:
- MangoHud → overlay e monitoramento;
- GOverlay → configuração visual do MangoHud;
- LACT → controle de GPU.

---

## Plataforma
`[Linux]`

---

## GitHub
https://github.com/benjamimgois/goverlay

## Releases
https://github.com/benjamimgois/goverlay/releases/latest

## Lembrete
Consultar documentação oficial sobre:
- dependências por distro;
- integração com vkBasalt;
- configuração do OptiScaler;
- uso via Flatpak vs AppImage.
