# =========================
# BOOTSTRAP DO CATÁLOGO MANUAL V1
# =========================
# Lê o Índice Geral (.md) como fonte inicial e gera o catalogo_manual.json
# com categoria e sistema preenchidos automaticamente.
# Aliases e tipo ficam vazios para curadoria manual posterior.
# Este script deve ser rodado UMA única vez.
# Após gerado, o catalogo_manual.json é fonte de verdade — não rodar novamente.

# $PSScriptRoot aponta para a pasta onde o script está (scripts/)
# Split-Path -Parent sobe um nível, chegando na raiz do projeto
$ROOT = Split-Path -Parent $PSScriptRoot

# -------------------------------------------------------
# LOCALIZAÇÃO DOS ARQUIVOS
# Get-ChildItem lista o conteúdo de uma pasta
# -Depth 0 limita a busca à raiz, sem entrar em subpastas
# Where-Object filtra pelo nome — case-insensitive por padrão
# Select-Object -First 1 pega apenas o primeiro resultado
# -ExpandProperty FullName retorna o caminho completo como string
# -------------------------------------------------------
$IndiceFile = Get-ChildItem -Path $ROOT -Depth 0 -File -Filter "*.md" |
    Where-Object { $_.Name -like "*indice*" } |
    Select-Object -First 1 -ExpandProperty FullName

$ManifestDir = Get-ChildItem -Path $ROOT -Depth 0 -Directory |
    Where-Object { $_.Name -like "*manifest*" } |
    Select-Object -First 1 -ExpandProperty FullName

$SAIDA = Join-Path $ManifestDir "catalogo_manual.json"

# -------------------------------------------------------
# VERIFICAÇÕES DE SEGURANÇA
# Test-Path verifica se um caminho existe no sistema de arquivos
# -not inverte a condição — equivalente ao ! do Bash
# -------------------------------------------------------
if (-not $IndiceFile -or -not (Test-Path $IndiceFile)) {
    Write-Host "[ERRO] Índice Geral não encontrado na raiz do projeto."
    Write-Host "Esperado: arquivo .md com 'indice' no nome em $ROOT"
    exit 1
}

if (-not $ManifestDir) {
    Write-Host "[ERRO] Pasta de manifesto não encontrada em: $ROOT"
    Write-Host "Esperado: pasta com 'manifest' no nome."
    exit 1
}

Write-Host "Índice encontrado: $IndiceFile"
Write-Host "Manifesto em: $ManifestDir"
Write-Host ""

# -------------------------------------------------------
# AVISO DE USO ÚNICO
# Protege a curadoria manual de ser sobrescrita acidentalmente
# Read-Host aguarda entrada do usuário — equivalente ao read do Bash
# -------------------------------------------------------
if (Test-Path $SAIDA) {
    Write-Host "[AVISO] catalogo_manual.json já existe."
    Write-Host "Este script é de bootstrap único — rodar novamente sobrescreve a curadoria manual."
    Write-Host ""
    $confirmacao = Read-Host "Deseja continuar mesmo assim? [s/N]"
    Write-Host ""
    if ($confirmacao -ne "s") {
        Write-Host "Operação cancelada."
        exit 0
    }
}

# -------------------------------------------------------
# MAPEAMENTO DE CATEGORIAS
# Hashtable — equivalente ao declare -A do Bash (array associativo)
# Chave = nome da seção no índice, Valor = categoria do vocabulário
# -------------------------------------------------------
$MapaCategorias = @{
    "Hardware / Benchmark"               = "hardware_benchmark"
    "Sistema / Windows"                  = "sistema_windows"
    "Sistema / Linux"                    = "sistema_linux"
    "Recuperação / Backup"               = "recuperacao_backup"
    "Rede / Infraestrutura"              = "rede_infraestrutura"
    "Reverse Engineering / Forensics"    = "reverse_engineering"
    "Segurança / Pentest"                = "seguranca_pentest"
    "Virtualização / Ambientes"          = "virtualizacao"
    "Laboratório Offline / Conhecimento" = "laboratorio_offline"
    "Criptografia / Senhas"              = "criptografia_senhas"
    "Organização / Utilidades"           = "organizacao_utilidades"
    "Desenvolvimento"                    = "desenvolvimento"
}

# -------------------------------------------------------
# INICIALIZA O ARRAY DE FERRAMENTAS
# ArrayList é uma lista dinâmica — cresce conforme adicionamos itens
# Equivalente ao array vazio [] que o jq ia construindo no Bash
# -------------------------------------------------------
$ferramentas = [System.Collections.Generic.List[object]]::new()
$categoriaAtual = ""

Write-Host "Lendo índice e gerando catálogo..."
Write-Host ""

# -------------------------------------------------------
# LEITURA DO ÍNDICE LINHA POR LINHA
# Get-Content lê o arquivo e retorna um array de linhas
# foreach percorre cada linha — equivalente ao while read do Bash
# -------------------------------------------------------
foreach ($linha in (Get-Content $IndiceFile)) {

    # Detecta cabeçalho de categoria (## Nome)
    # -match verifica se a linha bate com a expressão regular
    # $Matches[1] captura o grupo entre parênteses da regex
    if ($linha -match "^##\s+(.+)$") {
        $secao = $Matches[1].Trim()
        if ($MapaCategorias.ContainsKey($secao)) {
            $categoriaAtual = $MapaCategorias[$secao]
        }
        continue
    }

    # Detecta linha de ferramenta (- Nome `[Tag]`)
    if ($linha -match "^-\s+(.+)\s+\`\[(.+)\]\`$") {

        $nomeBruto = $Matches[1].Trim()
        $tag       = $Matches[2].Trim()

        # Remove sufixos entre parênteses — ex: "Tool (AltName)" vira "Tool"
        $nome = $nomeBruto -replace '\s+\(.*\)', ''

        # Gera ID limpo — remove tudo que não for letra ou número, converte para minúsculas
        $id = ($nome -replace '[^a-zA-Z0-9]', '').ToLower()

        # Mapeia a tag do índice para o vocabulário de sistemas
        $sistema = switch ($tag) {
            "Windows"          { @("windows") }
            "Linux"            { @("linux") }
            "Windows / Linux"  { @("ambos") }
            "Bootável"         { @("bootavel") }
            "Recurso"          { @("recurso") }
            default            { @() }
        }

        Write-Host "  + $nome [$categoriaAtual] [$($sistema -join ', ')]"

        # -------------------------------------------------------
        # MONTA O OBJETO DA FERRAMENTA
        # [PSCustomObject] cria um objeto com propriedades nomeadas
        # Equivalente ao objeto JSON que o jq montava no Bash
        # -------------------------------------------------------
        $item = [PSCustomObject]@{
            id           = $id
            nome         = $nome
            arquivo      = ""
            documentacao = ""
            sha256       = ""
            aliases      = @()
            categoria    = $categoriaAtual
            tipo         = @()
            sistema      = $sistema
        }

        # .Add() adiciona o item à lista — equivalente ao += do jq no Bash
        $ferramentas.Add($item)
    }
}

# -------------------------------------------------------
# SALVA O JSON
# ConvertTo-Json transforma os objetos PowerShell em JSON
# -Depth 5 garante que arrays aninhados sejam serializados corretamente
# Out-File salva o resultado em disco com encoding UTF8
# -------------------------------------------------------
$catalogo = [PSCustomObject]@{ ferramentas = $ferramentas }
$catalogo | ConvertTo-Json -Depth 5 | Out-File $SAIDA -Encoding UTF8

Write-Host ""
Write-Host "Bootstrap concluído."
Write-Host "Ferramentas catalogadas: $($ferramentas.Count)"
Write-Host "Arquivo salvo em: $SAIDA"
Write-Host ""
Write-Host "Próximos passos:"
Write-Host "  1. Abrir $SAIDA"
Write-Host "  2. Preencher 'aliases' e 'tipo' para cada ferramenta"
Write-Host "  3. Vincular 'arquivo' e 'documentacao' conforme disponível"