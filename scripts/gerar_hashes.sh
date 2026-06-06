#!/usr/bin/env bash
# =========================================================
# GERADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Caminhos — tolerante a variações de nome e maiúsculas/minúsculas
PASTA_DOCS="$(find "$ROOT" -maxdepth 1 -type d | grep -i "personal_doc\|documentacao\|docs" | head -1)"
FILES_HEALTH="$(find "$ROOT" -maxdepth 1 -type d | grep -i "files_health\|saude" | head -1)"
ARQUIVO_HASH="$FILES_HEALTH/hashes_sha256.txt"

# Verificações de segurança antes de qualquer escrita
if [ -z "$PASTA_DOCS" ]; then
    echo "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
fi

if [ -z "$FILES_HEALTH" ]; then
    echo "[ERRO] Pasta files_health não encontrada em: $ROOT"
    exit 1
fi

echo "Documentação: $PASTA_DOCS"
echo "Saída: $ARQUIVO_HASH"
echo ""

# Gera hashes
find "$PASTA_DOCS" -maxdepth 1 -type f -name "*.md" | sort | while read -r arquivo; do

    nome="$(basename "$arquivo")"

    if [ "$nome" = "hashes_sha256.txt" ]; then
        continue
    fi

    hash="$(sha256sum "$arquivo" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"
    echo "$nome | $hash"

done > "$ARQUIVO_HASH"

echo ""
echo "Hashes SHA256 gerados com sucesso."
echo "Arquivo salvo em: $ARQUIVO_HASH"
