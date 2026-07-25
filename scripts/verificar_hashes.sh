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

# Contadores para o resumo final
ok=0; alterados=0; faltando=0; invalidos=0
primeira_linha=1

# Lê e verifica linha por linha
while IFS= read -r linha || [ -n "$linha" ]; do

    # Remove CR de arquivos gerados no Windows — senão o \r entra no hash
    linha="${linha%$'\r'}"

    # Remove BOM UTF-8 da primeira linha — arquivos gerados por versões
    # antigas do gerar_hashes.ps1 (Out-File -Encoding UTF8) começam com ele
    if [ "$primeira_linha" -eq 1 ]; then
        linha="${linha#$'\xEF\xBB\xBF'}"
        primeira_linha=0
    fi

    [ -z "$linha" ] && continue

    # Separa nome e hash pelo delimitador " | "
    # Expansão de parâmetro em vez de awk: nomes de arquivo com espaço
    # sobrevivem intactos e não há regex para escapar errado
    arquivo="${linha%% | *}"
    hash_original="${linha##* | }"
    caminho_completo="$PASTA_DOCS/$arquivo"

    # Linha sem o delimitador esperado — arquivo de hashes corrompido
    if [ "$arquivo" = "$linha" ]; then
        echo "[INVÁLIDO] $linha"
        invalidos=$((invalidos + 1))
        continue
    fi

    if [ -f "$caminho_completo" ]; then
        hash_atual="$(sha256sum "$caminho_completo" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')"
        if [ "$hash_atual" = "$hash_original" ]; then
            echo "[OK] $arquivo"
            ok=$((ok + 1))
        else
            echo "[ALTERADO] $arquivo"
            alterados=$((alterados + 1))
        fi
    else
        echo "[FALTANDO] $arquivo"
        faltando=$((faltando + 1))
    fi

done < "$ARQUIVO_HASH"

echo ""
echo "------------------------------"
echo "OK: $ok | Alterados: $alterados | Faltando: $faltando | Inválidos: $invalidos"

# Sai com erro se algo não bateu — permite encadear em automação
if [ "$alterados" -gt 0 ] || [ "$faltando" -gt 0 ] || [ "$invalidos" -gt 0 ]; then
    exit 1
fi
