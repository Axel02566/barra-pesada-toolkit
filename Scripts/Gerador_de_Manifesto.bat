@echo off
title Gerador de Manifesto - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0gerar_manifesto.ps1"

echo.
echo Processo concluido.
pause