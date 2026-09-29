# =========================================================
# CONSTRUTOR DO WINPE — BARRA PESADA
# =========================================================
# Gera a ISO do WinPE custom a partir de receita.json.
# O ambiente é receita versionada: a ISO é descartável e
# pode ser refeita a qualquer momento com este script.
#
# Requisitos (só do lado Windows):
#   - Windows ADK + add-on do WinPE (mesma versão)
#   - PowerShell como administrador (o DISM exige)
#
# Uso:
#   .\construir_winpe.ps1 -Saida "D:\PESSOAL\BARRA PESADA\ISOS"
#
# Gancho de teste: o startnet.cmd da imagem procura
# \BP_SMOKE\smoke.cmd em qualquer unidade e o executa.
# Isso permite rodar a etapa 4 da bateria sem refazer a ISO.

param(
    [Parameter(Mandatory = $true)]
    [string]$Saida,

    # Pasta de trabalho temporária — sem espaços no caminho,
    # porque copype/MakeWinPEMedia são .cmd e sofrem com aspas
    [string]$Trabalho = "C:\BP_WinPE"
)

$ErrorActionPreference = "Stop"

# -------------------------------------------------------
# VERIFICAÇÕES
# -------------------------------------------------------
$Admin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $Admin) {
    Write-Host "[ERRO] Execute como administrador (o DISM exige)."
    exit 1
}

$Receita = Get-Content -Raw -Encoding UTF8 (Join-Path $PSScriptRoot "receita.json") | ConvertFrom-Json
$Arq = $Receita.arquitetura

$ADK = Join-Path ${env:ProgramFiles(x86)} "Windows Kits\10\Assessment and Deployment Kit"
$WinPERoot = Join-Path $ADK "Windows Preinstallation Environment"
$OCs = Join-Path $WinPERoot "$Arq\WinPE_OCs"

if (-not (Test-Path (Join-Path $WinPERoot "copype.cmd"))) {
    Write-Host "[ERRO] Windows ADK / add-on do WinPE não encontrado em: $ADK"
    Write-Host "Instale os dois (mesma versão) a partir da página oficial da Microsoft:"
    Write-Host "  https://learn.microsoft.com/windows-hardware/get-started/adk-install"
    exit 1
}

if (Test-Path $Trabalho) {
    Write-Host "[ERRO] Pasta de trabalho já existe: $Trabalho"
    Write-Host "Se sobrou de uma execução anterior, confira com 'Dism /Get-MountedImageInfo',"
    Write-Host "desmonte com 'Dism /Unmount-Image /MountDir:$Trabalho\mount /Discard' e apague a pasta."
    exit 1
}

New-Item -ItemType Directory -Force -Path $Saida | Out-Null

# Mesmas variáveis que o DandISetEnv.bat define — herdadas pelos .cmd do ADK
$env:WinPERoot   = $WinPERoot
$env:OSCDImgRoot = Join-Path $ADK "Deployment Tools\$Arq\Oscdimg"
$env:DandIRoot   = Join-Path $ADK "Deployment Tools"
$env:Path = "$WinPERoot;$(Join-Path $ADK "Deployment Tools\$Arq\DISM");$env:OSCDImgRoot;$env:Path"

$Montagem = Join-Path $Trabalho "mount"
$Wim = Join-Path $Trabalho "media\sources\boot.wim"
$Montado = $false

function Invocar([string]$Descricao, [scriptblock]$Comando) {
    Write-Host "  - $Descricao"
    & $Comando | Out-Host
    if ($LASTEXITCODE -ne 0) { throw "falhou: $Descricao (código $LASTEXITCODE)" }
}

try {
    Write-Host ""
    Write-Host "Construindo $($Receita.nome) ($Arq)"
    Write-Host ""

    Invocar "copype" { cmd.exe /c copype.cmd $Arq $Trabalho }

    Invocar "montando boot.wim" { Dism.exe /Mount-Image /ImageFile:$Wim /Index:1 /MountDir:$Montagem }
    $Montado = $true

    # -------------------------------------------------------
    # COMPONENTES — na ordem da receita, cada um com seu idioma
    # -------------------------------------------------------
    foreach ($Comp in $Receita.componentes) {
        $Cab = Join-Path $OCs "$Comp.cab"
        $CabIdioma = Join-Path $OCs "$($Receita.idioma)\$($Comp)_$($Receita.idioma).cab"
        Invocar "$Comp" { Dism.exe /Image:$Montagem /Add-Package /PackagePath:$Cab }
        if (Test-Path $CabIdioma) {
            Invocar "$Comp ($($Receita.idioma))" { Dism.exe /Image:$Montagem /Add-Package /PackagePath:$CabIdioma }
        }
    }

    # O padrão de 32 MB de scratch é pouco para rodar ferramentas
    Invocar "scratch space $($Receita.scratch_mb) MB" { Dism.exe /Image:$Montagem /Set-ScratchSpace:$($Receita.scratch_mb) }

    # -------------------------------------------------------
    # GANCHO DE TESTE NO STARTNET.CMD
    # -------------------------------------------------------
    Write-Host "  - startnet.cmd com gancho \BP_SMOKE\smoke.cmd"
    $Startnet = @(
        "wpeinit",
        "for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%d:\BP_SMOKE\smoke.cmd (call %%d:\BP_SMOKE\smoke.cmd %%d: & goto :fim)",
        ":fim"
    )
    Set-Content -Path (Join-Path $Montagem "Windows\System32\startnet.cmd") -Value $Startnet -Encoding Ascii

    Invocar "gravando e desmontando" { Dism.exe /Unmount-Image /MountDir:$Montagem /Commit }
    $Montado = $false

    # ISO gerada dentro da pasta de trabalho (caminho sem espaços) e movida depois
    $IsoTemp = Join-Path $Trabalho "$($Receita.nome).iso"
    Invocar "gerando ISO" { cmd.exe /c MakeWinPEMedia.cmd /ISO /F $Trabalho $IsoTemp }

    $IsoFinal = Join-Path $Saida "$($Receita.nome).iso"
    Move-Item -Force $IsoTemp $IsoFinal
    $Hash = (Get-FileHash -Algorithm SHA256 $IsoFinal).Hash
    Set-Content -Path "$IsoFinal.sha256" -Value "$Hash  $($Receita.nome).iso" -Encoding Ascii

    Write-Host ""
    Write-Host "Concluído."
    Write-Host "ISO: $IsoFinal"
    Write-Host "SHA256: $Hash"
}
catch {
    Write-Host ""
    Write-Host "[ERRO] $_"
    if ($Montado) {
        Write-Host "Descartando imagem montada..."
        Dism.exe /Unmount-Image /MountDir:$Montagem /Discard | Out-Host
        if ($LASTEXITCODE -eq 0) { $Montado = $false }
    }
    exit 1
}
finally {
    if (-not $Montado -and (Test-Path $Trabalho)) {
        Remove-Item -Recurse -Force $Trabalho -ErrorAction SilentlyContinue
    }
}
