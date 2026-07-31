# =========================
# HUB DE CONTROLE V1
# BARRA PESADA — Toolkit
# =========================

$ScriptDir = $PSScriptRoot

while ($true) {
    Write-Host ""
    Write-Host "=============================="
    Write-Host "  HUB DE CONTROLE"
    Write-Host "  BARRA PESADA — Toolkit"
    Write-Host "=============================="
    Write-Host ""
    Write-Host "  1) Verificar saúde dos arquivos (hashes)"
    Write-Host "  2) Regenerar hashes SHA256"
    Write-Host "  3) Buscar ferramenta no catálogo"
    Write-Host "  4) Sair"
    Write-Host ""

    $opcao = Read-Host "Escolha uma opção [1-4]"
    Write-Host ""

    switch ($opcao) {
        "1" {
            & (Join-Path $ScriptDir "verificar_hashes.ps1")
        }
        "2" {
            $confirma = Read-Host "Isso sobrescreve hashes_sha256.txt com o estado atual de personal_doc/. Confirma? [s/N]"
            if ($confirma -eq "s" -or $confirma -eq "S") {
                & (Join-Path $ScriptDir "gerar_hashes.ps1")
            } else {
                Write-Host "Cancelado."
            }
        }
        "3" {
            & (Join-Path $ScriptDir "buscar_manifesto.ps1")
        }
        "4" {
            exit 0
        }
        default {
            Write-Host "[ERRO] Opção inválida."
        }
    }
}
