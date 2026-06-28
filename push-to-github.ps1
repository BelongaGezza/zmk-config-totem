# push-to-github.ps1
# ─────────────────────────────────────────────────────────────────────────────
# Run this once from PowerShell (or right-click → "Run with PowerShell") to
# fix the broken .git folder left by the failed clone, commit all files, and
# push to GitHub.
#
# Prerequisites:
#   - Git for Windows installed and in PATH
#   - GitHub credentials configured (SSH key or HTTPS credential helper)
# ─────────────────────────────────────────────────────────────────────────────

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoRoot

Write-Host "Working in: $repoRoot" -ForegroundColor Cyan

# 1. Remove the broken .git folder left by the failed clone
if (Test-Path ".git") {
    Write-Host "Removing broken .git folder..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force ".git"
}

# 2. Initialise a fresh local repo
Write-Host "Initialising git repo..." -ForegroundColor Cyan
git init -b master

# 3. Set identity if not already configured globally
$userName  = git config --global user.name  2>$null
$userEmail = git config --global user.email 2>$null
if (-not $userName)  { git config user.name  "Gerry" }
if (-not $userEmail) { git config user.email "gerrygillies@gmail.com" }

# 4. Point at the upstream remote
Write-Host "Adding remote..." -ForegroundColor Cyan
git remote add origin https://github.com/BelongaGezza/zmk-config-totem.git

# 5. Stage everything
Write-Host "Staging files..." -ForegroundColor Cyan
git add -A
git status --short

# 6. Commit
Write-Host "Committing..." -ForegroundColor Cyan
git commit -m "feat: dongle mode, multi-host BT, native Makerdiary board, ZMK Studio

- Add totem_dongle shield (nrf52840_mdk_usb_dongle//zmk — native board support)
- Add totem_left_peripheral shield (left half as BLE peripheral for dongle mode)
- Update Kconfig.defconfig: dongle central config, BT_MAX_CONN=3, PERIPHERALS=2
- Update Kconfig.shield: register SHIELD_TOTEM_DONGLE, SHIELD_TOTEM_LEFT_PERIPHERAL
- Fix board names for ZMK main / Zephyr 4.1:
    seeeduino_xiao_ble -> xiao_ble//zmk
- Add ZMK board extension for Makerdiary nRF52840 MDK USB Dongle:
    zephyr/module.yml: declares repo as Zephyr module, board_root: config
    config/boards/makerdiary/nrf52840_mdk_usb_dongle/board.yml: extend + //zmk variant
    Kconfig.nrf52840_mdk_usb_dongle: select ZMK_BOARD_COMPAT for //zmk variant
    nrf52840_mdk_usb_dongle_nrf52840_zmk.dts: ZMK DTS entry; includes Zephyr base
    nrf52840_mdk_usb_dongle_nrf52840_zmk_defconfig: USB, BLE, NVS, UF2 defaults
- Add ZMK Studio support:
    totem-layouts.dtsi: 38-key physical layout from QMK keyboard.json (centiunits)
    totem.dtsi + totem_dongle.overlay: zmk,physical-layout replaces zmk,matrix-transform
    build.yaml: studio-rpc-usb-uart snippet + CONFIG_ZMK_STUDIO=y on central targets
    totem.keymap: studio_unlock on ADJ layer (Y-column top row)
- Update west.yml / build.yml: v0.3 -> main
- Update KEYMAP_GUIDE.md: operating modes, dongle flashing, multi-host BT switching
- Add SETUP_NOTES.md: change log, build targets, flashing instructions
- Add docs/MAKERDIARY_DONGLE_PLAN.md: pin analysis, flash safety, implementation record"

# 7. Push — force-push because the remote has history we're replacing
Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
Write-Host "(If prompted, enter your GitHub username and a Personal Access Token as the password)" -ForegroundColor Yellow
git push --force origin master

Write-Host ""
Write-Host "Done! Check https://github.com/BelongaGezza/zmk-config-totem" -ForegroundColor Green
Write-Host "GitHub Actions will build all firmware targets automatically." -ForegroundColor Green
