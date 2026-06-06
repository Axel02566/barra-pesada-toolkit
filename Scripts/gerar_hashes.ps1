# =========================================================
# GERADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
$ROOT = Split-Path -Parent $PSScriptRoot

# Define caminhos
$PastaDocs   = Join-Path $ROOT "documentacao"
$ArquivoHash = Join-Path $ROOT "SAUDE_DOS_ARQUIVOS\hashes_sha256.txt"

# Gera hashes
Get-ChildItem -Path $PastaDocs -File *.md |
Where-Object { $_.Name -ne "hashes_sha256.txt" } |
ForEach-Object {
    $hash = Get-FileHash $_.FullName -Algorithm SHA256
    "$($_.Name) | $($hash.Hash)"
} | Out-File $ArquivoHash -Encoding UTF8

Write-Host ""
Write-Host "Hashes SHA256 gerados com sucesso."
Write-Host "Arquivo salvo em:"
Write-Host $ArquivoHash