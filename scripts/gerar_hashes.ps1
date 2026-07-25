# =========================================================
# GERADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
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

# Verificações antes de qualquer escrita
if (-not $PastaDocs) {
    Write-Host "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
}

if (-not $FilesHealth) {
    Write-Host "[ERRO] Pasta files_health não encontrada em: $ROOT"
    exit 1
}

$ArquivoHash = Join-Path $FilesHealth "hashes_sha256.txt"

Write-Host "Documentação: $PastaDocs"
Write-Host "Saída: $ArquivoHash"
Write-Host ""

# Gera hashes — ordenado por nome para bater com o `sort` do equivalente .sh
$linhas = Get-ChildItem -Path $PastaDocs -File -Filter "*.md" |
    Sort-Object Name |
    ForEach-Object {
        $hash = Get-FileHash $_.FullName -Algorithm SHA256
        "$($_.Name) | $($hash.Hash)"
    }

# -------------------------------------------------------
# ESCRITA
# Out-File gravaria BOM e CRLF, e o leitor Bash trataria o
# BOM como parte do primeiro nome e o CR como parte do hash.
# WriteAllText com UTF8 sem BOM e LF mantém o arquivo legível
# pelos dois lados do toolkit.
# -------------------------------------------------------
$utf8SemBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($ArquivoHash, ($linhas -join "`n") + "`n", $utf8SemBom)

Write-Host ""
Write-Host "Hashes SHA256 gerados com sucesso."
Write-Host "Arquivo salvo em:"
Write-Host $ArquivoHash
