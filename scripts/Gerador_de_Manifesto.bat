@echo off
title Gerador de Manifesto - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0gerador_de_manifesto.ps1"

echo.
echo Processo concluido.
pause