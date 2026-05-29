$PastaDocs = "E:\BARRA PESADA\documentacao"
$ArquivoHash = "E:\BARRA PESADA\saude_dos_arquivos\hashes_sha256.txt"

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
