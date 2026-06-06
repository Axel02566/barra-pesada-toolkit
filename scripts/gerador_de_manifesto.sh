#!/usr/bin/env bash
# =========================
# GERADOR DE MANIFESTO V1
# =========================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Define caminhos
FERRAMENTAS_PATH="$ROOT/ferramentas"
DOCS_PATH="$ROOT/documentacao"
SAIDA_PATH="$ROOT/manifesto/manifest_temp.json"

# Verifica se as pastas existem
if [ ! -d "$FERRAMENTAS_PATH" ]; then
    echo "[ERRO] Pasta de ferramentas não encontrada: $FERRAMENTAS_PATH"
    exit 1
fi

if [ ! -d "$DOCS_PATH" ]; then
    echo "[ERRO] Pasta de documentação não encontrada: $DOCS_PATH"
    exit 1
fi

# Inicializa o JSON com array vazio
manifesto='{"ferramentas":[]}'

# Varre os arquivos da pasta ferramentas
while IFS= read -r arquivo; do

    nome_arquivo="$(basename "$arquivo")"
    base="${nome_arquivo%.*}"

    echo "Processando: $nome_arquivo"

    # Gera ID limpo — remove tudo que não for letra ou número, converte para minúsculas
    id="$(echo "$base" | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]')"

    # Procura markdown correspondente por similaridade de nome
    doc_encontrada=""
    while IFS= read -r md; do
        md_base="$(basename "$md")"
        md_id="$(echo "${md_base%.*}" | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]')"

        if echo "$md_id" | grep -qi "$id"; then
            doc_encontrada="$md_base"
            break
        fi
    done < <(find "$DOCS_PATH" -maxdepth 1 -type f -name "*.md" | sort)

    # Gera hash SHA256 com proteção contra erro
    if hash_raw="$(sha256sum "$arquivo" 2>/dev/null)"; then
        hash_final="$(echo "$hash_raw" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"
    else
        echo "[ERRO HASH] $nome_arquivo"
        hash_final="ERRO"
    fi

    # Monta o item e adiciona ao manifesto via jq
    manifesto="$(echo "$manifesto" | jq \
        --arg id           "$id" \
        --arg nome         "$base" \
        --arg arquivo      "$nome_arquivo" \
        --arg documentacao "$doc_encontrada" \
        --arg sha256       "$hash_final" \
        '.ferramentas += [{
            id:           $id,
            nome:         $nome,
            arquivo:      $arquivo,
            documentacao: $documentacao,
            sha256:       $sha256,
            aliases:      [],
            categoria:    "",
            tipo:         [],
            sistema:      []
        }]'
    )"

done < <(find "$FERRAMENTAS_PATH" -maxdepth 1 -type f | sort)

# Salva o JSON formatado
echo "$manifesto" | jq '.' > "$SAIDA_PATH"

echo ""
echo "Manifesto gerado com sucesso:"
echo "$SAIDA_PATH"
