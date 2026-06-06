#!/usr/bin/env bash
# =========================================================
# GERADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Define caminhos
PASTA_DOCS="$ROOT/documentacao"
ARQUIVO_HASH="$ROOT/saude_dos_arquivos/hashes_sha256.txt"

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
echo "Arquivo salvo em:"
echo "$ARQUIVO_HASH"
