# =========================
# GERADOR DE MANIFESTO V1
# =========================

$ROOT = Split-Path -Parent $PSScriptRoot

# -------------------------------------------------------
# LOCALIZAÇÃO DAS PASTAS
# Tolerante a variações de nome e maiúsculas/minúsculas,
# igual ao equivalente .sh — não depende de nome fixo
# -------------------------------------------------------
$FerramentasPath = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -match "ferramentas|tools" } |
    Select-Object -First 1 -ExpandProperty FullName

$DocsPath = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -match "personal_doc|documentacao|docs" } |
    Select-Object -First 1 -ExpandProperty FullName

$ManifestDir = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -like "*manifest*" } |
    Select-Object -First 1 -ExpandProperty FullName

# Verifica se as pastas existem
if (-not $FerramentasPath) {
    Write-Host "[ERRO] Pasta de ferramentas não encontrada em: $ROOT"
    Write-Host "Esperado: pasta com 'ferramentas' ou 'tools' no nome."
    exit 1
}

if (-not $DocsPath) {
    Write-Host "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
}

if (-not $ManifestDir) {
    Write-Host "[ERRO] Pasta de manifesto não encontrada em: $ROOT"
    exit 1
}

$SaidaPath = Join-Path $ManifestDir "manifest_temp.json"

Write-Host "Ferramentas: $FerramentasPath"
Write-Host "Documentação: $DocsPath"
Write-Host "Saída: $SaidaPath"
Write-Host ""

$manifesto = @{
    ferramentas = @()
}

$arquivos = Get-ChildItem $FerramentasPath -File

foreach ($arquivo in $arquivos) {

    Write-Host "Processando: $($arquivo.Name)"

    # Remove caracteres especiais do ID
    $id = ($arquivo.BaseName -replace '[^a-zA-Z0-9]', '').ToLower()

    # Procura markdown correspondente
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
        id           = $id
        nome         = $arquivo.BaseName
        arquivo      = $arquivo.Name
        documentacao = if ($docEncontrada) { $docEncontrada.Name } else { "" }
        sha256       = $hashFinal
        aliases      = @()
        categoria    = ""
        tipo         = @()
        sistema      = @()
    }

    $manifesto.ferramentas += $item
}

# Salva JSON — UTF8 sem BOM, senão jq e o buscador .sh engasgam no BOM
$json = $manifesto | ConvertTo-Json -Depth 5
$utf8SemBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($SaidaPath, $json, $utf8SemBom)

Write-Host ""
Write-Host "Manifesto gerado com sucesso:"
Write-Host $SaidaPath