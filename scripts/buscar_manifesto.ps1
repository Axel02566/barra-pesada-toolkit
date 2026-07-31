# =========================
# BUSCADOR DE MANIFESTO V1
# =========================

# $PSScriptRoot é uma variável automática do PowerShell
# Sempre contém o caminho da pasta onde o script está
$ROOT = Split-Path -Parent $PSScriptRoot

# -------------------------------------------------------
# LOCALIZAÇÃO DO MANIFESTO
# Usa Get-ChildItem para varrer a raiz do projeto
# Where-Object filtra pelo nome — case-insensitive por padrão
# -------------------------------------------------------
$ManifestDir = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -like "*manifest*" } |
    Select-Object -First 1 -ExpandProperty FullName

$ManifestFile = Join-Path $ManifestDir "catalogo_manual.json"

# Test-Path verifica existência de arquivo ou pasta
# -not inverte a condição, equivalente ao ! do Bash
if (-not (Test-Path $ManifestFile)) {
    Write-Host "[ERRO] Manifesto não encontrado: $ManifestFile"
    Write-Host "Execute bootstrap_catalogo.ps1 primeiro."
    exit 1
}

# -------------------------------------------------------
# LEITURA DO JSON
# Get-Content lê o arquivo como texto
# ConvertFrom-Json transforma o texto em objeto PowerShell
# Não precisa de jq — é nativo
# -------------------------------------------------------
$dados = Get-Content $ManifestFile -Raw | ConvertFrom-Json

# -------------------------------------------------------
# MENU INTERATIVO
# Read-Host exibe uma mensagem e aguarda entrada do usuário
# Equivalente ao read -rp do Bash
# -------------------------------------------------------
Write-Host ""
Write-Host "=============================="
Write-Host "  BUSCADOR DE MANIFESTO"
Write-Host "  BARRA PESADA — Toolkit"
Write-Host "=============================="
Write-Host ""
Write-Host "Buscar por:"
Write-Host "  1) Nome"
Write-Host "  2) Alias"
Write-Host "  3) Categoria"
Write-Host "  4) Tipo"
Write-Host "  5) Sistema"
Write-Host "  6) Arquivo"
Write-Host ""

$opcao = Read-Host "Escolha uma opção [1-6]"
Write-Host ""

# -------------------------------------------------------
# SWITCH — equivalente ao case/esac do Bash
# Mapeia a opção escolhida para o nome do campo no JSON
# -------------------------------------------------------
switch ($opcao) {
    "1" { $campo = "nome" }
    "2" { $campo = "aliases" }
    "3" { $campo = "categoria" }
    "4" { $campo = "tipo" }
    "5" { $campo = "sistema" }
    "6" { $campo = "arquivo" }
    default {
        Write-Host "[ERRO] Opção inválida."
        exit 1
    }
}

$termo = Read-Host "Termo de busca"
Write-Host ""

# -------------------------------------------------------
# BUSCA
# Where-Object filtra os objetos do array .ferramentas
# $_ representa o objeto atual no pipeline — equivalente
# à variável de loop implícita do Bash
#
# Campos de array (aliases, tipo, sistema, arquivo) precisam de
# tratamento diferente de campos de string simples
# -------------------------------------------------------
if ($campo -in @("aliases", "tipo", "sistema", "arquivo")) {

    # Campos que são arrays — verifica se algum elemento contém o termo
    $resultados = $dados.ferramentas | Where-Object {
        $_.($campo) | Where-Object { $_ -like "*$termo*" }
    }

} else {

    # Campos que são strings — comparação direta
    # -like com asteriscos faz busca parcial, case-insensitive
    $resultados = $dados.ferramentas | Where-Object {
        $_.($campo) -like "*$termo*"
    }

}

# -------------------------------------------------------
# EXIBIÇÃO DOS RESULTADOS
# foreach percorre cada item encontrado
# O operador ternário ( ? : ) escolhe entre dois valores
# dependendo de uma condição
# -------------------------------------------------------
if (-not $resultados) {
    Write-Host "Nenhum resultado encontrado para `"$termo`" em [$campo]."
} else {
    Write-Host "Resultados para `"$termo`" em [$campo]:"
    Write-Host "------------------------------"

    foreach ($item in $resultados) {

        # Se documentacao estiver vazia, exibe "(nenhuma)"
        $doc = if ($item.documentacao -ne "") { $item.documentacao } else { "(nenhuma)" }

        Write-Host "  Ferramenta : $($item.nome)"
        Write-Host "  Documentação: $doc"
        Write-Host ""
    }
}