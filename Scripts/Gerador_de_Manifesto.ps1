# =========================
# GERADOR DE MANIFESTO V1
# =========================

$FerramentasPath = "E:\BARRA PESADA\FERRAMENTAS"
$DocsPath = "E:\BARRA PESADA\DOCUMENTACAO"

$SaidaPath = "E:\BARRA PESADA\manifest_temp.json"

# Verifica se as pastas existem
if (!(Test-Path $FerramentasPath)) {
    Write-Host "[ERRO] Pasta de ferramentas não encontrada."
    exit
}

if (!(Test-Path $DocsPath)) {
    Write-Host "[ERRO] Pasta de documentação não encontrada."
    exit
}

$manifesto = @{
    ferramentas = @()
}

$arquivos = Get-ChildItem $FerramentasPath -File

foreach ($arquivo in $arquivos) {

    Write-Host "Processando: $($arquivo.Name)"

    # Remove caracteres especiais do ID
    $id = ($arquivo.BaseName -replace '[^a-zA-Z0-9]', '').ToLower()

    # Procura markdown parecido
    $docEncontrada = Get-ChildItem $DocsPath -Filter "*.md" |
        Where-Object {
            ($_.BaseName -replace '[^a-zA-Z0-9]', '').ToLower() -like "*$id*"
        } |
        Select-Object -First 1

    # Gera hash com proteção
    try {
        $hash = Get-FileHash $arquivo.FullName -Algorithm SHA256
        $hashFinal = $hash.Hash
    }
    catch {
        Write-Host "[ERRO HASH] $($arquivo.Name)"
        $hashFinal = "ERRO"
    }

    # Estrutura do item
    $item = @{
        id = $id
        nome = $arquivo.BaseName
        arquivo = $arquivo.Name
        documentacao = if ($docEncontrada) { $docEncontrada.Name } else { "" }
        sha256 = $hashFinal
        aliases = @()
        categoria = ""
        tipo = @()
        sistema = @()
    }

    $manifesto.ferramentas += $item
}

# Salva JSON
$manifesto |
    ConvertTo-Json -Depth 5 |
    Out-File $SaidaPath -Encoding UTF8

Write-Host ""
Write-Host "Manifesto gerado com sucesso:"
Write-Host $SaidaPath