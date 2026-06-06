#!/usr/bin/env bash
# =========================================================
# VERIFICADOR DE HASHES SHA256 DA DOCUMENTAÇÃO
# =========================================================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Caminhos — tolerante a variações de nome e maiúsculas/minúsculas
PASTA_DOCS="$(find "$ROOT" -maxdepth 1 -type d | grep -i "personal_doc\|documentacao\|docs" | head -1)"
FILES_HEALTH="$(find "$ROOT" -maxdepth 1 -type d | grep -i "files_health\|saude" | head -1)"
ARQUIVO_HASH="$FILES_HEALTH/hashes_sha256.txt"

# Verificações de segurança
if [ -z "$PASTA_DOCS" ]; then
    echo "[ERRO] Pasta de documentação não encontrada em: $ROOT"
    exit 1
fi

if [ -z "$FILES_HEALTH" ]; then
    echo "[ERRO] Pasta files_health não encontrada em: $ROOT"
    exit 1
fi

if [ ! -f "$ARQUIVO_HASH" ]; then
    echo "[ERRO] Arquivo de hashes não encontrado: $ARQUIVO_HASH"
    echo "Execute gerar_hashes.sh primeiro."
    exit 1
fi

echo "Documentação: $PASTA_DOCS"
echo "Hashes: $ARQUIVO_HASH"
echo ""

# Lê e verifica linha por linha
while IFS= read -r linha; do

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
