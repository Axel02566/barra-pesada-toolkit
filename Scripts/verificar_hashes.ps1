$PastaDocs = "E:\BARRA PESADA\documentacao"
$ArquivoHash = "E:\BARRA PESADA\saude_dos_arquivos\hashes_sha256.txt"

$hashes = Get-Content $ArquivoHash

foreach ($linha in $hashes) {

    $partes = $linha -split " \| "

    $arquivo = $partes[0]
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