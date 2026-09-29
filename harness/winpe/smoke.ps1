# =========================================================
# BATERIA WINPE — ETAPA 4, LADO WINPE (RUNNER)
# =========================================================
# Chamado pelo smoke.cmd, que o startnet.cmd da receita
# encontra em \BP_SMOKE\ de qualquer unidade.
#
# Para cada linha de testes.tsv: inicia o executável, espera
# alguns segundos e registra o que aconteceu em
# resultados\resultados.jsonl. Nada aqui é interativo.

param(
    [Parameter(Mandatory = $true)]
    [string]$Raiz
)

$ErrorActionPreference = "Continue"
$Res = Join-Path $Raiz "resultados"
New-Item -ItemType Directory -Force -Path $Res | Out-Null
$Saida = Join-Path $Res "resultados.jsonl"
Set-Content -Path (Join-Path $Res "inicio.txt") -Value (Get-Date -Format s)

$Config = Get-Content -Raw -Encoding UTF8 (Join-Path $Raiz "config.json") | ConvertFrom-Json
$Espera = [int]$Config.espera_segundos

# -------------------------------------------------------
# SEM CAIXAS DE ERRO
# DLL ausente abre uma caixa que trava o processo até alguém
# clicar. SetErrorMode é herdado pelos processos filhos.
# P/Invoke por Reflection.Emit: não depende do csc.exe.
# -------------------------------------------------------
try {
    $Asm = [AppDomain]::CurrentDomain.DefineDynamicAssembly(
        (New-Object Reflection.AssemblyName "BPErro"), [Reflection.Emit.AssemblyBuilderAccess]::Run)
    $Tipo = $Asm.DefineDynamicModule("BPErro").DefineType("BPErro.K", "Public,Class")
    $Tipo.DefinePInvokeMethod("SetErrorMode", "kernel32.dll",
        [Reflection.MethodAttributes]"Public,Static,PinvokeImpl",
        [Reflection.CallingConventions]::Standard, [uint32], [Type[]]@([uint32]),
        [Runtime.InteropServices.CallingConvention]::Winapi,
        [Runtime.InteropServices.CharSet]::Auto) | Out-Null
    # SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX | SEM_NOOPENFILEERRORBOX
    $K = $Tipo.CreateType()
    $K::SetErrorMode(0x8003) | Out-Null
    $ModoErro = $true
} catch {
    $ModoErro = $false
}

# -------------------------------------------------------
# AMBIENTE — responde direto a pergunta do WoW64
# -------------------------------------------------------
[ordered]@{
    wow64            = Test-Path "$env:SystemRoot\SysWOW64\kernel32.dll"
    arquitetura      = $env:PROCESSOR_ARCHITECTURE
    versao           = [Environment]::OSVersion.VersionString
    powershell       = $PSVersionTable.PSVersion.ToString()
    dotnet           = Test-Path "$env:SystemRoot\Microsoft.NET\Framework64"
    wmi              = [bool](Get-Command Get-WmiObject -ErrorAction SilentlyContinue)
    dialogos_supressos = $ModoErro
} | ConvertTo-Json | Set-Content -Encoding UTF8 (Join-Path $Res "ambiente.json")

# -------------------------------------------------------
# UTILIDADES
# -------------------------------------------------------
# Códigos NTSTATUS de falha do carregador (ExitCode vem com sinal)
$NTSTATUS = @{
    -1073741515 = "dll_ausente"               # 0xC0000135
    -1073741511 = "ponto_de_entrada_ausente"  # 0xC0000139
    -1073741701 = "imagem_invalida"           # 0xC000007B
    -1073741502 = "falha_init_dll"            # 0xC0000142
}

function Capturar([string]$Arquivo) {
    try {
        Add-Type -AssemblyName System.Windows.Forms, System.Drawing -ErrorAction Stop
        $Tela = [System.Windows.Forms.SystemInformation]::VirtualScreen
        $Bmp = New-Object System.Drawing.Bitmap $Tela.Width, $Tela.Height
        $G = [System.Drawing.Graphics]::FromImage($Bmp)
        $G.CopyFromScreen($Tela.Location, [System.Drawing.Point]::Empty, $Tela.Size)
        $Bmp.Save($Arquivo, [System.Drawing.Imaging.ImageFormat]::Png)
        $G.Dispose(); $Bmp.Dispose()
        return $true
    } catch {
        return $false
    }
}

function Trecho([string]$Arquivo) {
    if (Test-Path $Arquivo) {
        return ((Get-Content -Path $Arquivo -TotalCount 5 -ErrorAction SilentlyContinue) -join " | ")
    }
    return ""
}

function Encerrar-Restos {
    Get-Process -ErrorAction SilentlyContinue |
        Where-Object { $_.Path -and $_.Path.StartsWith($Raiz, [StringComparison]::OrdinalIgnoreCase) } |
        Stop-Process -Force -ErrorAction SilentlyContinue
}

$Vazio = Join-Path $Raiz "vazio.txt"
if (-not (Test-Path $Vazio)) { New-Item -ItemType File -Force -Path $Vazio | Out-Null }

# -------------------------------------------------------
# TESTES
# testes.tsv: id, raiz, caminho relativo, arquitetura, subsistema
# -------------------------------------------------------
$Linhas = Get-Content -Encoding UTF8 (Join-Path $Raiz "testes.tsv")
$Total = $Linhas.Count
$I = 0

foreach ($Linha in $Linhas) {
    if (-not $Linha.Trim()) { continue }
    $I++
    $Id, $N, $Rel, $Arq, $Sub = $Linha -split "`t"
    $Exe = Join-Path $Raiz "f\$Id\$N\$Rel"
    $Out = Join-Path $Res "$I.out.txt"
    $Err = Join-Path $Res "$I.err.txt"
    Write-Host "[$I/$Total] $Id :: $Rel"

    $Registro = [ordered]@{ n = $I; id = $Id; exe = $Rel; arquitetura = $Arq; subsistema = $Sub }
    $Inicio = Get-Date

    if (-not (Test-Path $Exe)) {
        $Registro.resultado = "nao_encontrado"
    } else {
        try {
            $P = Start-Process -FilePath $Exe -WorkingDirectory (Split-Path $Exe) -PassThru `
                -RedirectStandardInput $Vazio -RedirectStandardOutput $Out -RedirectStandardError $Err `
                -ErrorAction Stop
            $null = $P.Handle  # sem isso o ExitCode volta vazio no PowerShell 5.1

            if ($P.WaitForExit($Espera * 1000)) {
                $Registro.codigo = $P.ExitCode
                if ($NTSTATUS.ContainsKey($P.ExitCode)) {
                    $Registro.resultado = $NTSTATUS[$P.ExitCode]
                } else {
                    $Registro.resultado = "encerrou"
                }
            } else {
                $P.Refresh()
                $Janela = $P.MainWindowHandle
                if ($Janela -ne [IntPtr]::Zero) {
                    $Registro.resultado = "janela_aberta"
                } else {
                    $Registro.resultado = "em_execucao"
                }
                if ($Sub -eq "gui") {
                    $Png = Join-Path $Res "$I.png"
                    if (Capturar $Png) { $Registro.captura = "$I.png" }
                }
                Stop-Process -Id $P.Id -Force -ErrorAction SilentlyContinue
            }
        } catch {
            # Ex.: 32 bits sem WoW64 -> ERROR_BAD_EXE_FORMAT (193) / EXE_MACHINE_TYPE_MISMATCH (216)
            $Base = $_.Exception.GetBaseException()
            $Registro.resultado = "falha_inicio"
            if ($Base -is [ComponentModel.Win32Exception]) { $Registro.codigo = $Base.NativeErrorCode }
            $Registro.detalhe = $Base.Message
        }
    }

    $Saida1 = Trecho $Out
    $Saida2 = Trecho $Err
    if ($Saida1) { $Registro.stdout = $Saida1 }
    if ($Saida2) { $Registro.stderr = $Saida2 }
    $Registro.segundos = [math]::Round(((Get-Date) - $Inicio).TotalSeconds, 1)

    $Registro | ConvertTo-Json -Compress | Add-Content -Encoding UTF8 -Path $Saida
    Encerrar-Restos
}

Set-Content -Path (Join-Path $Res "fim.txt") -Value (Get-Date -Format s)
