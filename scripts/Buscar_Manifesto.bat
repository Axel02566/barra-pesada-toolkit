@echo off
title Buscador de Manifesto - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0buscar_manifesto.ps1"

echo.
pause