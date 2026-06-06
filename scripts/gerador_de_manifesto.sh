#!/usr/bin/env bash
# =========================
# GERADOR DE MANIFESTO V1
# =========================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Caminhos — tolerante a variações de nome e maiúsculas/minúsculas
FERRAMENTAS_PATH="$(find "$ROOT" -maxdepth 1 -type d | grep -i "ferramentas\|tools" | head -1)"
DOCS_PATH="$(find "$ROOT" -maxdepth 1 -type d | grep -i "personal_doc\|documentacao\|docs" | head -1)"
MANIFESTO_DIR="$(find "$ROOT" -maxdepth 1 -type d | grep -i "manifest" | head -1)"
SAIDA_PATH="$MANIFESTO_DIR/manifest_temp.json"

# Verificações de segurança antes de qualquer escrita
if [ -z "$FERRAMENTAS_PATH" ]; then
    echo "[ERRO] Pasta de ferramentas não encontrada em: $ROOT"
    exit 1
fi

if [ -z "$DOCS_PATH" ]; then
    echo "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
fi

if [ -z "$MANIFESTO_DIR" ]; then
    echo "[ERRO] Pasta de manifesto não encontrada em: $ROOT"
    exit 1
fi

echo "Ferramentas: $FERRAMENTAS_PATH"
echo "Documentação: $DOCS_PATH"
echo "Saída: $SAIDA_PATH"
echo ""

# Verifica se jq está instalado
if ! command -v jq &>/dev/null; then
    echo "[ERRO] jq não encontrado. Instale com: sudo apt install jq"
    exit 1
fi

# Inicializa o JSON com array vazio
manifesto='{"ferramentas":[]}'

# Varre os arquivos da pasta ferramentas
while IFS= read -r arquivo; do

    nome_arquivo="$(basename "$arquivo")"
    base="${nome_arquivo%.*}"

    echo "Processando: $nome_arquivo"

    # Gera ID limpo
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

    # Gera hash SHA256
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
echo "Manifesto gerado com sucesso."
echo "Arquivo salvo em: $SAIDA_PATH"
