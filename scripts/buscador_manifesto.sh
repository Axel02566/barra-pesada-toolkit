#!/usr/bin/env bash
# =========================
# BUSCADOR DE MANIFESTO V1
# =========================

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Caminhos — tolerante a variações de nome e maiúsculas/minúsculas
MANIFESTO_DIR="$(find "$ROOT" -maxdepth 1 -type d | grep -i "manifest" | head -1)"

if [ -z "$MANIFESTO_DIR" ]; then
    echo "[ERRO] Pasta de manifesto não encontrada em: $ROOT"
    echo "Esperado: pasta com 'manifest' no nome."
    exit 1
fi

# Fonte de verdade é o catálogo curado — mesmo arquivo lido por buscar_manifesto.ps1
MANIFESTO="$MANIFESTO_DIR/catalogo_manual.json"

# Verifica se o catálogo existe
if [ ! -f "$MANIFESTO" ]; then
    echo "[ERRO] Catálogo não encontrado: $MANIFESTO"
    echo "Execute bootstrap_catalogo.sh primeiro."
    exit 1
fi

# Verifica se jq está instalado
if ! command -v jq &>/dev/null; then
    echo "[ERRO] jq não encontrado. Instale com: sudo apt install jq"
    exit 1
fi

# -------------------------
# Menu de campos de busca
# -------------------------
echo ""
echo "=============================="
echo "  BUSCADOR DE MANIFESTO"
echo "  BARRA PESADA — Toolkit"
echo "=============================="
echo ""
echo "Buscar por:"
echo "  1) Nome"
echo "  2) Alias"
echo "  3) Categoria"
echo "  4) Tipo"
echo "  5) Sistema"
echo "  6) Arquivo"
echo ""
read -rp "Escolha uma opção [1-6]: " opcao
echo ""

# Valida opção
case "$opcao" in
    1) campo="nome"      ;;
    2) campo="aliases"   ;;
    3) campo="categoria" ;;
    4) campo="tipo"      ;;
    5) campo="sistema"   ;;
    6) campo="arquivo"   ;;
    *)
        echo "[ERRO] Opção inválida."
        exit 1
        ;;
esac

read -rp "Termo de busca: " termo
echo ""

# -------------------------
# Executa busca via jq
# -------------------------
if [ "$campo" = "aliases" ] || [ "$campo" = "tipo" ] || [ "$campo" = "sistema" ] || [ "$campo" = "arquivo" ]; then
    # Campos que são arrays — busca dentro do array
    resultados="$(jq -r \
        --arg termo "$termo" \
        '.ferramentas[] |
        select(.'"$campo"'[] | ascii_downcase | contains($termo | ascii_downcase)) |
        "  Ferramenta : " + .nome,
        "  Documentação: " + (if .documentacao == "" then "(nenhuma)" else .documentacao end),
        ""' \
        "$MANIFESTO")"
else
    # Campos que são strings — busca direta
    resultados="$(jq -r \
        --arg termo "$termo" \
        '.ferramentas[] |
        select(.'"$campo"' | ascii_downcase | contains($termo | ascii_downcase)) |
        "  Ferramenta : " + .nome,
        "  Documentação: " + (if .documentacao == "" then "(nenhuma)" else .documentacao end),
        ""' \
        "$MANIFESTO")"
fi

# -------------------------
# Exibe resultados
# -------------------------
if [ -z "$resultados" ]; then
    echo "Nenhum resultado encontrado para \"$termo\" em [$campo]."
else
    echo "Resultados para \"$termo\" em [$campo]:"
    echo "------------------------------"
    echo "$resultados"
fi