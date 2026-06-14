@echo off
title Bootstrap do Catálogo - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0bootstrap_catalogo.ps1"

echo.
echo Processo concluido.
pause