# =========================================================
# VERIFICADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

$ROOT = Split-Path -Parent $PSScriptRoot

$PastaDocs   = Join-Path $ROOT "documentacao"
$ArquivoHash = Join-Path $ROOT "SAUDE_DOS_ARQUIVOS\hashes_sha256.txt"

$hashes = Get-Content $ArquivoHash

foreach ($linha in $hashes) {

    $partes = $linha -split " \| "

    $arquivo      = $partes[0]
    $hashOriginal = $partes[1]

    $caminhoCompleto = Join-Path $PastaDocs $arquivo

    if (Test-Path $caminhoCompleto) {

        $hashAtual = (Get-FileHash $caminhoCompleto -Algorithm SHA256).Hash

        if ($hashAtual -eq $hashOriginal) {
            Write-Host "[OK] $arquivo"
        }
        else {
            Write-Host "[ALTERADO] $arquivo"
        }

    }
    else {
        Write-Host "[FALTANDO] $arquivo"
    }
}