@echo off
title Verificar Hashes SHA256 - Barra Pesada

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0verificar_hashes.ps1"

echo.
pause