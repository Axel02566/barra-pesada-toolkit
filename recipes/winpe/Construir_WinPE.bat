@echo off
title Construtor do WinPE - Barra Pesada

rem Precisa ser aberto com "Executar como administrador"
set /p SAIDA="Pasta de saida da ISO: "

powershell -ExecutionPolicy Bypass -NoProfile -File "%~dp0construir_winpe.ps1" -Saida "%SAIDA%"

echo.
pause
