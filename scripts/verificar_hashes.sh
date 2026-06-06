#!/usr/bin/env bash
# =========================================================
# VERIFICADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Define caminhos
PASTA_DOCS="$ROOT/documentacao"
ARQUIVO_HASH="$ROOT/saude_dos_arquivos/hashes_sha256.txt"

# Verifica se o arquivo de hashes existe
if [ ! -f "$ARQUIVO_HASH" ]; then
    echo "Arquivo de hashes não encontrado: $ARQUIVO_HASH"
    echo "Execute gerar_hashes.sh primeiro."
    exit 1
fi

# Lê e verifica linha por linha
while IFS= read -r linha; do

    # Ignora linhas vazias
    [ -z "$linha" ] && continue

    arquivo="$(echo "$linha" | awk -F ' \| ' '{print $1}')"
    hash_original="$(echo "$linha" | awk -F ' \| ' '{print $2}')"

    caminho_completo="$PASTA_DOCS/$arquivo"

    if [ -f "$caminho_completo" ]; then

        hash_atual="$(sha256sum "$caminho_completo" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"

        if [ "$hash_atual" = "$hash_original" ]; then
            echo "[OK] $arquivo"
        else
            echo "[ALTERADO] $arquivo"
        fi

    else
        echo "[FALTANDO] $arquivo"
    fi

done < "$ARQUIVO_HASH"
