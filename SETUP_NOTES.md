# SETUP NOTES — Totem Dongle & Multi-Host Configuration

> Change log and one-time setup instructions.  See `docs/KEYMAP_GUIDE.md` for
> full operating-mode detail, flashing steps, and BT profile usage.

---

## Change log — 2026-06-28 (ZMK Studio)

### Summary

Added ZMK Studio support so keymaps can be edited in real-time via the Studio
app at https://zmkfirmware.dev/studio/ without reflashing.

### Files changed

| File | Change |
|---|---|
| `config/boards/shields/totem/totem-layouts.dtsi` | **NEW** — 38-key physical layout; positions from QMK keyboard.json (centiunits) |
| `config/boards/shields/totem/totem.dtsi` | `zmk,matrix-transform` → `zmk,physical-layout`; include `totem-layouts.dtsi` |
| `config/boards/shields/totem/totem_dongle.overlay` | Same chosen change + include |
| `build.yaml` | Added `snippet: studio-rpc-usb-uart` and `cmake-args: -DCONFIG_ZMK_STUDIO=y` to the two central targets (`totem_left`, `totem_dongle`) |
| `config/totem.keymap` | Added `&studio_unlock` on ADJ layer (Y column, top row) |

### Using ZMK Studio

1. Flash the updated firmware to the central (dongle in Mode 1, left half in Mode 2/3+).
2. Connect the central to your PC via **USB** (Studio requires USB — Bluetooth is not supported).
3. Open **https://zmkfirmware.dev/studio/** in Chrome or Edge, then click **Connect**.
4. Select the TOTEM device from the browser serial port picker.
5. The keyboard will appear **locked**. Unlock it from the keyboard:
   - Hold **Tab** (NAV) → hold **Enter** (ADJ) → tap the key in the **Y column, top row** (innermost top-right key).
   - Alternative path: hold **Esc** (SYM) → hold **left thumb inner** (ADJ) → tap the same key.
6. The web app will show the full Totem layout. Remap any key — changes write to flash and persist across power cycles.

> Studio edits survive firmware reflashing. To discard them, use **Reset to default** in the Studio web app.

### Physical layout source

Key positions are derived from `GEIGEIGEIST/TOTEM/firmware/QMK/VIAL_source/totem/keyboard.json`
and converted from QMK key-units to ZMK centiunits (multiply by 100).
The transform order matches `totem_dongle.overlay` and `totem.dtsi` exactly.

---

## Change log — 2026-06-28 (Native Makerdiary board)

### Summary

Added native ZMK board support for the Makerdiary nRF52840 MDK USB Dongle.
The build now targets `nrf52840_mdk_usb_dongle//zmk` directly — the PCA10059
workaround and all overlay hacks have been removed.

Also investigated flash safety (dongle bootloader confirmed safe from any
partition in the DTS), documented findings in `docs/MAKERDIARY_DONGLE_PLAN.md`.

### Files changed

| File | Change |
|---|---|
| `zephyr/module.yml` | **NEW** — declares repo as Zephyr module; enables `ZMK_EXTRA_MODULES` in CI so custom board is found at build time |
| `config/boards/makerdiary/nrf52840_mdk_usb_dongle/board.yml` | **NEW** — ZMK `extend:` extension for the Makerdiary board; declares `//zmk` variant |
| `config/boards/makerdiary/nrf52840_mdk_usb_dongle/Kconfig.nrf52840_mdk_usb_dongle` | **NEW** — `select ZMK_BOARD_COMPAT` when building `//zmk` variant |
| `config/boards/makerdiary/nrf52840_mdk_usb_dongle/nrf52840_mdk_usb_dongle_nrf52840_zmk.dts` | **NEW** — ZMK DTS entry point; includes Zephyr upstream board DTS |
| `config/boards/makerdiary/nrf52840_mdk_usb_dongle/nrf52840_mdk_usb_dongle_nrf52840_zmk_defconfig` | **NEW** — ZMK Kconfig defaults (USB, BLE, NVS, UF2 output) |
| `build.yaml` | Dongle target: `nrf52840dongle//zmk` → `nrf52840_mdk_usb_dongle//zmk` |
| `config/boards/shields/totem/totem_dongle.zmk.yml` | `requires: [nrf52840dongle]` → `requires: [nrf52840_mdk_usb_dongle]` |
| `config/boards/shields/totem/totem_dongle.overlay` | Removed LED GPIO remaps and storage_partition override (correct in native board DTS) |
| `config/boards/shields/totem/totem_dongle.conf` | Removed USB/BLE/UF2 config (now in board defconfig); kept `ZMK_USB_LOGGING=n` |
| `docs/MAKERDIARY_DONGLE_PLAN.md` | **NEW** — pin comparison, flash layout safety analysis, implementation record |

### How the board extension works

ZMK's CI (`build-user-config.yml`) checks for `zephyr/module.yml` at repo root.
If present, it sets `ZMK_EXTRA_MODULES=${GITHUB_WORKSPACE}`, which tells the Zephyr
build system to treat the repo as a module.  `zephyr/module.yml` declares
`board_root: config`, so Zephyr searches `config/boards/` for board definitions.

The `board.yml` in `config/boards/makerdiary/nrf52840_mdk_usb_dongle/` uses
`extend: nrf52840_mdk_usb_dongle` to layer ZMK support on top of the Zephyr
upstream board (which already exists in HWMv2 format in Zephyr's tree).  The CI
board-compat check skips for this board (it only checks ZMK's own board roots),
so there is no blocking error.

---

## Change log — 2026-06-27

### Summary

Added full 3-board dongle support (Mode 1) and documented multi-host Bluetooth
switching (Modes 2/3+) which was already functional in the existing firmware.

### Files changed

| File | Change |
|---|---|
| `config/west.yml` | `v0.3` → `main` (required for nrf52840_mdk_usb_dongle board) |
| `.github/workflows/build.yml` | `@v0.3` → `@main` to match |
| `build.yaml` | Added Mode 1 targets: `totem_dongle`, `totem_left_peripheral` |
| `Kconfig.shield` | Added `SHIELD_TOTEM_DONGLE`, `SHIELD_TOTEM_LEFT_PERIPHERAL` |
| `Kconfig.defconfig` | Added dongle central config (`BT_MAX_CONN=3`, `BT_MAX_PAIRED=3`, `ZMK_SPLIT_BLE_CENTRAL_PERIPHERALS=2`) |
| `totem_dongle.overlay` | **NEW** — nRF52840 MDK USB Dongle as split central with mock kscan |
| `totem_dongle.conf` | **NEW** — `CONFIG_ZMK_USB=y`, BLE kept on for peripheral comms |
| `totem_dongle.keymap` | **NEW** — includes `totem.keymap` for identical bindings in both modes |
| `totem_dongle.zmk.yml` | **NEW** — shield metadata |
| `totem_left_peripheral.overlay` | **NEW** — left half as BLE peripheral (dongle mode) |
| `totem_left_peripheral.conf` | **NEW** — peripheral-only config (no central role) |
| `totem.zmk.yml` | Added `totem_left_peripheral` to siblings list |
| `docs/KEYMAP_GUIDE.md` | Expanded with operating modes, multi-host BT, dongle flashing |

### Why `v0.3` → `main`

`nrf52840_mdk_usb_dongle` is not present in ZMK v0.3.  `main` adds this board
and includes split-stack improvements that make 3-board dongle setups reliable.

**Stability note:** `main` is a rolling target.  If you need reproducible
builds, pin `revision` in `config/west.yml` to a specific commit hash after a
successful CI run.

---

## First-time ZMK workspace setup (local builds)

Only needed if building locally rather than via GitHub Actions.

```bash
# Create west workspace outside this repo
mkdir zmk-workspace && cd zmk-workspace

# Initialise pointing at this config
west init -l /path/to/zmk-config-totem/config

# Fetch ZMK and Zephyr dependencies
west update

# Python dependencies
pip install -r zephyr/scripts/requirements.txt
```

---

## Build targets at a glance

| Mode | Board | Shield | Flash to |
|------|-------|--------|---------|
| 1 — Dongle central | `nrf52840_mdk_usb_dongle//zmk` | `totem_dongle` | Makerdiary nRF52840 MDK USB Dongle |
| 1 — Left peripheral | `xiao_ble//zmk` | `totem_left_peripheral` | Left XIAO BLE |
| 1/2 — Right (shared) | `xiao_ble//zmk` | `totem_right` | Right XIAO BLE |
| 2/3+ — Left central | `xiao_ble//zmk` | `totem_left` | Left XIAO BLE |

The right half binary is identical for all modes — flash it once.

### Flashing the Makerdiary MDK USB Dongle (UF2)

The dongle must be put into UF2 bootloader mode before flashing:

1. **Hold the button** on the dongle while inserting it into the PC's USB port.
2. Release the button once inserted — the dongle will appear as a USB drive (e.g. `MDK-DONGLE`).
3. Drag and drop `totem_dongle-nrf52840_mdk_usb_dongle.uf2` onto the drive.
4. The drive will disappear and the dongle will reboot into the new firmware automatically.

> If the dongle does not appear as a drive, try a different USB port or cable.  Some
> USB hubs do not supply enough power during bootloader enumeration.

See `docs/KEYMAP_GUIDE.md → Operating modes` for full pairing and switching instructions.

---

## Platform testing checklist

> Per CLAUDE.md §9 — flags tests that could not be completed from this Windows session.

- [ ] `TODO(test): verify dongle pairing on Windows 11` — hardware required
- [ ] `TODO(test): verify dongle pairing on macOS` — requires macOS session
- [ ] `TODO(test): verify Mode 2 BT multi-profile switching on Windows and macOS`
- [ ] `TODO(test): confirm ZMK main builds cleanly with nrf52840_mdk_usb_dongle` — CI will verify
