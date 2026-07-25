# =========================================================
# VERIFICADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
$ROOT = Split-Path -Parent $PSScriptRoot

# -------------------------------------------------------
# LOCALIZAÇÃO DAS PASTAS
# Tolerante a variações de nome e maiúsculas/minúsculas,
# igual aos equivalentes .sh — não depende de nome fixo
# -------------------------------------------------------
$PastaDocs = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -match "personal_doc|documentacao|docs" } |
    Select-Object -First 1 -ExpandProperty FullName

$FilesHealth = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -match "files_health|saude" } |
    Select-Object -First 1 -ExpandProperty FullName

if (-not $PastaDocs) {
    Write-Host "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
}

if (-not $FilesHealth) {
    Write-Host "[ERRO] Pasta files_health não encontrada em: $ROOT"
    exit 1
}

$ArquivoHash = Join-Path $FilesHealth "hashes_sha256.txt"

if (-not (Test-Path $ArquivoHash)) {
    Write-Host "[ERRO] Arquivo de hashes não encontrado: $ArquivoHash"
    Write-Host "Execute gerar_hashes.ps1 primeiro."
    exit 1
}

Write-Host "Documentação: $PastaDocs"
Write-Host "Hashes: $ArquivoHash"
Write-Host ""

$hashes = Get-Content $ArquivoHash

# Contadores para o resumo final
$ok = 0; $alterados = 0; $faltando = 0; $invalidos = 0

foreach ($linha in $hashes) {

    if ([string]::IsNullOrWhiteSpace($linha)) { continue }

    # -split usa regex: \| escapa o pipe para ser lido como literal.
    # Limite de 2 campos para não quebrar nomes que contenham " | "
    $partes = $linha -split " \| ", 2

    if ($partes.Count -lt 2) {
        Write-Host "[INVÁLIDO] $linha"
        $invalidos++
        continue
    }

    $arquivo      = $partes[0]
    $hashOriginal = $partes[1].Trim()

    $caminhoCompleto = Join-Path $PastaDocs $arquivo

    if (Test-Path $caminhoCompleto) {

        $hashAtual = (Get-FileHash $caminhoCompleto -Algorithm SHA256).Hash

        if ($hashAtual -eq $hashOriginal) {
            Write-Host "[OK] $arquivo"
            $ok++
        }
        else {
            Write-Host "[ALTERADO] $arquivo"
            $alterados++
        }

    }
    else {
        Write-Host "[FALTANDO] $arquivo"
        $faltando++
    }
}

Write-Host ""
Write-Host "------------------------------"
Write-Host "OK: $ok | Alterados: $alterados | Faltando: $faltando | Inválidos: $invalidos"
