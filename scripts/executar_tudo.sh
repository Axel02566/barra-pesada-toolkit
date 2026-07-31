#!/usr/bin/env bash
# =========================
# HUB DE CONTROLE V1
# BARRA PESADA — Toolkit
# =========================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while true; do
    echo ""
    echo "=============================="
    echo "  HUB DE CONTROLE"
    echo "  BARRA PESADA — Toolkit"
    echo "=============================="
    echo ""
    echo "  1) Verificar saúde dos arquivos (hashes)"
    echo "  2) Regenerar hashes SHA256"
    echo "  3) Buscar ferramenta no catálogo"
    echo "  4) Sair"
    echo ""
    read -rp "Escolha uma opção [1-4]: " opcao
    echo ""

    case "$opcao" in
        1)
            bash "$SCRIPT_DIR/verificar_hashes.sh"
            ;;
        2)
            read -rp "Isso sobrescreve hashes_sha256.txt com o estado atual de personal_doc/. Confirma? [s/N]: " confirma
            if [ "$confirma" = "s" ] || [ "$confirma" = "S" ]; then
                bash "$SCRIPT_DIR/gerar_hashes.sh"
            else
                echo "Cancelado."
            fi
            ;;
        3)
            bash "$SCRIPT_DIR/buscador_manifesto.sh"
            ;;
        4)
            exit 0
            ;;
        *)
            echo "[ERRO] Opção inválida."
            ;;
    esac
done
