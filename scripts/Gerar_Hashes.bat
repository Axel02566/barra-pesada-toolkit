@echo off
title Gerar Hashes SHA256 - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0gerar_hashes.ps1"

echo.
pause