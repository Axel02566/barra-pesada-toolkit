#!/usr/bin/env bash
# =========================
# BOOTSTRAP DO CATÁLOGO MANUAL V1
# =========================
# Lê o Índice Geral (.md) como fonte inicial e gera o catalogo_manual.json
# com categoria e sistema preenchidos automaticamente.
# Aliases e tipo ficam vazios para curadoria manual posterior.
# Este script deve ser rodado UMA única vez.
# Após gerado, o catalogo_manual.json é fonte de verdade — não rodar novamente.

# Descobre a raiz do projeto
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$SCRIPT_DIR")"

# Caminhos — tolerante a variações de nome e maiúsculas/minúsculas
INDICE="$(find "$ROOT" -maxdepth 1 -type f -name "*.md" | grep -i "indice" | head -1)"
MANIFESTO_DIR="$(find "$ROOT" -maxdepth 1 -type d | grep -i "manifest" | head -1)"
SAIDA="$MANIFESTO_DIR/catalogo_manual.json"

# Verifica dependências
if ! command -v jq &>/dev/null; then
    echo "[ERRO] jq não encontrado. Instale com: sudo apt install jq"
    exit 1
fi

if [ -z "$INDICE" ] || [ ! -f "$INDICE" ]; then
    echo "[ERRO] Índice Geral não encontrado na raiz do projeto."
    echo "Esperado: arquivo .md com 'indice' no nome em $ROOT"
    exit 1
fi

if [ -z "$MANIFESTO_DIR" ]; then
    echo "[ERRO] Pasta de manifesto não encontrada em: $ROOT"
    echo "Esperado: pasta com 'manifest' no nome."
    exit 1
fi

echo "Índice encontrado: $INDICE"
echo "Manifesto em: $MANIFESTO_DIR"
echo ""

# Aviso de uso único
if [ -f "$SAIDA" ]; then
    echo "[AVISO] catalogo_manual.json já existe."
    echo "Este script é de bootstrap único — rodar novamente sobrescreve a curadoria manual."
    echo ""
    read -rp "Deseja continuar mesmo assim? [s/N]: " confirmacao
    echo ""
    if [[ ! "$confirmacao" =~ ^[Ss]$ ]]; then
        echo "Operação cancelada."
        exit 0
    fi
fi

# Inicializa catálogo
catalogo='{"ferramentas":[]}'

# Mapeamento de seções do índice para categorias do vocabulário
declare -A MAPA_CATEGORIAS
MAPA_CATEGORIAS["Hardware / Benchmark"]="hardware_benchmark"
MAPA_CATEGORIAS["Sistema / Windows"]="sistema_windows"
MAPA_CATEGORIAS["Sistema / Linux"]="sistema_linux"
MAPA_CATEGORIAS["Recuperação / Backup"]="recuperacao_backup"
MAPA_CATEGORIAS["Rede / Infraestrutura"]="rede_infraestrutura"
MAPA_CATEGORIAS["Reverse Engineering / Forensics"]="reverse_engineering"
MAPA_CATEGORIAS["Segurança / Pentest"]="seguranca_pentest"
MAPA_CATEGORIAS["Virtualização / Ambientes"]="virtualizacao"
MAPA_CATEGORIAS["Laboratório Offline / Conhecimento"]="laboratorio_offline"
MAPA_CATEGORIAS["Criptografia / Senhas"]="criptografia_senhas"
MAPA_CATEGORIAS["Organização / Utilidades"]="organizacao_utilidades"
MAPA_CATEGORIAS["Desenvolvimento"]="desenvolvimento"

categoria_atual=""

echo "Lendo índice e gerando catálogo..."
echo ""

# Lê o índice linha por linha
while IFS= read -r linha; do

    # Detecta cabeçalho de categoria (## Nome)
    if [[ "$linha" =~ ^##[[:space:]](.+)$ ]]; then
        secao="${BASH_REMATCH[1]}"
        for chave in "${!MAPA_CATEGORIAS[@]}"; do
            if [[ "$secao" == "$chave" ]]; then
                categoria_atual="${MAPA_CATEGORIAS[$chave]}"
                break
            fi
        done
        continue
    fi

    # Detecta linha de ferramenta (- Nome `[Tag]`)
    if [[ "$linha" =~ ^-[[:space:]](.+)[[:space:]]\`\[(.+)\]\` ]]; then

        nome_bruto="${BASH_REMATCH[1]}"
        tag="${BASH_REMATCH[2]}"

        # Remove sufixos entre parênteses do nome
        nome="$(echo "$nome_bruto" | sed 's/ (.*//')"

        # Gera ID limpo
        id="$(echo "$nome" | tr -cd '[:alnum:]' | tr '[:upper:]' '[:lower:]')"

        # Mapeia tag para sistema
        case "$tag" in
            "Windows")          sistema='["windows"]' ;;
            "Linux")            sistema='["linux"]' ;;
            "Windows / Linux")  sistema='["ambos"]' ;;
            "Bootável")         sistema='["bootavel"]' ;;
            "Recurso")          sistema='["recurso"]' ;;
            *)                  sistema='[]' ;;
        esac

        echo "  + $nome [$categoria_atual] $sistema"

        # Adiciona entrada ao catálogo via jq
        catalogo="$(echo "$catalogo" | jq \
            --arg id          "$id" \
            --arg nome        "$nome" \
            --arg categoria   "$categoria_atual" \
            --argjson sistema "$sistema" \
            '.ferramentas += [{
                id:           $id,
                nome:         $nome,
                arquivo:      "",
                documentacao: "",
                sha256:       "",
                aliases:      [],
                categoria:    $categoria,
                tipo:         [],
                sistema:      $sistema
            }]'
        )"
    fi

done < "$INDICE"

# Salva catálogo formatado
echo "$catalogo" | jq '.' > "$SAIDA"

echo ""
echo "Bootstrap concluído."
echo "Ferramentas catalogadas: $(echo "$catalogo" | jq '.ferramentas | length')"
echo "Arquivo salvo em: $SAIDA"
echo ""
echo "Próximos passos:"
echo "  1. Abrir $SAIDA"
echo "  2. Preencher 'aliases' e 'tipo' para cada ferramenta"
echo "  3. Vincular 'arquivo' e 'documentacao' conforme disponível"