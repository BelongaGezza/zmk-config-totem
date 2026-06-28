# Plan: Makerdiary nRF52840 MDK USB Dongle Support for ZMK

> **Status:** Planning — workaround applied (LED pins + storage partition corrected in overlay)  
> **Objective:** Use the Makerdiary nRF52840 MDK USB Dongle as the USB-HID central in  
> Mode 1 with native board support, replacing the current PCA10059 workaround.

---

## 1. Hardware context

| Component | Part | Notes |
|---|---|---|
| Left half MCU | Seeed XIAO BLE (nRF52840) | Acts as BLE central (Mode 2/3+) or BLE peripheral (Mode 1) |
| Right half MCU | Seeed XIAO BLE (nRF52840) | Always BLE peripheral |
| Dongle | **Makerdiary nRF52840 MDK USB Dongle** | nRF52840 SoC; USB-A plug; UF2 bootloader |
| Dongle (current workaround) | Nordic nRF52840 USB Dongle (PCA10059) | `nrf52840dongle//zmk` — ZMK-supported but not the hardware in hand |

The Makerdiary MDK USB Dongle and the Nordic PCA10059 use the **same nRF52840 SoC**
and both support the **UF2 bootloader**.  The firmware is **not** directly
binary-compatible due to different GPIO pin mappings and flash partition layouts —
but the differences have been characterised and a safe workaround is in place (see
Section 5a).

### Pin and partition differences (from Zephyr upstream DTS comparison)

**LEDs:**

| Signal | PCA10059 | Makerdiary MDK |
|---|---|---|
| LED 0 | P0.06 — green | P0.23 — red |
| LED 1 | P0.08 — red | P0.22 — green |
| LED 2 | P1.09 — green (RGB) | P0.24 — blue |
| LED 3 | P0.12 — blue (RGB) | *(none — 3 LEDs only)* |

ZMK uses `led0` (alias → LED 0) for connection status.  With uncorrected PCA10059
firmware, the status LED drives the wrong pin and LED 3 drives an exposed GPIO.

**Flash partitions (safety-critical):**

| Partition | PCA10059 | Makerdiary | Impact |
|---|---|---|---|
| slot0 (app code) | `0x10000` | `0x10000` | ✅ identical — safe to flash |
| storage (ZMK bonds) | `0xdc000` | `0xcc000` | ❌ different — bond data at wrong address |
| Bootloader start | `0xe0000` | `0xf4000` | Both safely above all app partitions |

Flashing PCA10059 firmware via UF2 **will not brick the Makerdiary dongle** because
the UF2 bootloader protects its own region and all writable addresses stay below
`0xf4000`.  The storage partition mismatch means bond data accumulates at `0xdc000`
(unused space on the Makerdiary) — harmless but should be corrected.

**UART pinctrl:** TX/RX on different pins; irrelevant because ZMK disables UART logging
on the dongle (`CONFIG_ZMK_USB_LOGGING=n`).  Button pin also differs; irrelevant for
ZMK dongle operation.

---

## 2. Repository

| Item | Value |
|---|---|
| GitHub | https://github.com/BelongaGezza/zmk-config-totem |
| Local path | `C:\Users\gerry\develop\zmk-config-totem` |
| ZMK revision | `main` (Zephyr 4.1, HWMv2) |
| CI | GitHub Actions — `zmkfirmware/zmk/.github/workflows/build-user-config.yml@main` |

Current `build.yaml` dongle target (workaround):

```yaml
- board: nrf52840dongle//zmk
  shield: totem_dongle
```

Target state after this work:

```yaml
- board: nrf52840_mdk_usb_dongle//zmk
  shield: totem_dongle
```

---

## 3. Root cause — why the Makerdiary dongle isn't currently supported

ZMK main uses **Zephyr 4.1 + Hardware Model v2 (HWMv2)**.  Under HWMv2, every
board that wants to work with ZMK must supply a ZMK board extension (a `//zmk`
variant).  The Makerdiary MDK USB Dongle exists in Zephyr's upstream tree as a
Zephyr board (`nrf52840_mdk_usb_dongle`), but **ZMK has not added a `//zmk`
extension for it**.  The CI gate "Check If Board not explicitly compatible" catches
this and fails the build.

The Nordic PCA10059 (`nrf52840dongle//zmk`) **does** have a ZMK extension, which
is why the workaround passes CI.

---

## 4. Precedent — what has been done before

### 4.1 `tungd/corne-mdk` (working, but pre-HWMv2)

Repository: https://github.com/tungd/corne-mdk

This repo successfully uses the Makerdiary MDK USB Dongle with ZMK by bundling
an **out-of-tree board definition** inside the user config repo at:

```
config/boards/arm/nrf52840_mdk_usb_dongle/
    Kconfig
    Kconfig.board
    Kconfig.defconfig
    board.cmake
    nrf52840_mdk_usb_dongle-pinctrl.dtsi
    nrf52840_mdk_usb_dongle.dts
    nrf52840_mdk_usb_dongle.yaml
    nrf52840_mdk_usb_dongle_defconfig
    pre_dt_board.cmake
    fstab-debugger.dts
    fstab-stock.dts
```

**Critical limitation:** these files are in the old **HWMv1** format.  The repo's
CI also uses the old hand-rolled workflow (`zmkfirmware/zmk-build-arm:3.0` Docker
image), not the current reusable `build-user-config.yml`.  As a result, this
approach does **not** work with current ZMK main without porting to HWMv2.

### 4.2 `kemonine/keyboard` (attempted, outcome unknown)

Commit: https://git.kemonine.info/kemonine/keyboard/commit/86ea1fa15095ed8f44fcf8e82de6a593df48e785  
Title: "First attempts at getting the mdk dongle working with zmk"  
No evidence of a successful follow-up in that repository.

---

## 5a. Current workaround (applied)

While native support is pending, `totem_dongle.overlay` has been updated to correct
the two meaningful differences when running PCA10059 firmware on Makerdiary hardware:

**LED GPIO remapping** — overrides PCA10059 LED nodes to drive Makerdiary's actual pins:
- `led0_green` → P0.22 (Makerdiary green)
- `led1_red` → P0.23 (Makerdiary red)
- `led1_green` → P0.24 (Makerdiary blue — closest available)
- `led1_blue` → P0.22 (redirected to same pin as green, preventing a floating GPIO drive)

**Storage partition** — overrides `storage_partition` address from `0xdc000` (PCA10059)
to `0xcc000` (Makerdiary), so ZMK bond data is stored at the correct flash location.

The workaround build still targets `nrf52840dongle//zmk` in `build.yaml` (passes CI).
The resulting UF2 is safe to flash onto the Makerdiary dongle.

---

## 5b. Technical approach for full native support

**Key finding from Zephyr upstream inspection:** The Makerdiary MDK USB Dongle is
**already in the Zephyr upstream tree in HWMv2 format** at
`boards/makerdiary/nrf52840_mdk_usb_dongle/` with a `board.yml` present.

This means the original plan to port the entire board definition is **unnecessary**.
Only a **ZMK board extension** (the `//zmk` variant) needs to be added — a much
smaller scope of work.

The `tungd/corne-mdk` HWMv1 files are now redundant as a reference source; use the
Zephyr upstream board directly.

### Files needed (ZMK extension only)

```
config/boards/arm/nrf52840_mdk_usb_dongle/
    nrf52840_mdk_usb_dongle_nrf52840_zmk.conf    # CONFIG_ZMK_USB=y, CONFIG_ZMK_BLE=y
    nrf52840_mdk_usb_dongle.zmk.yml              # variant descriptor → passes CI compat check
```

The `nrf52840_mdk_usb_dongle.zmk.yml` declares the board as ZMK-compatible and
registers the `//zmk` variant — this is the only thing making CI fail currently.

---

## 6. Step-by-step implementation plan (revised)

~~Steps 1–3 from original plan are superseded.~~  Zephyr already has a complete
HWMv2 board definition; no porting of the `tungd/corne-mdk` HWMv1 files is needed.

### Step 1 — Determine exact `.zmk.yml` variant descriptor format (RESEARCH)

Read the ZMK Zephyr 4.1 blog and examine an existing ZMK extension for a Zephyr board
(not a ZMK-native board) to see the exact `.zmk.yml` format required.

- **ZMK blog:** https://zmk.dev/blog/2025/12/09/zephyr-4-1#zmk-board-variant
- **Example — `nrf52840dongle` ZMK extension:** `https://github.com/zmkfirmware/zmk/tree/main/app/boards/arm/nrf52840dongle`

Key questions:
- Does `nrf52840_mdk_usb_dongle.zmk.yml` need a `variants:` section or just a board declaration?
- Does the conf file need a specific naming pattern (e.g. `_nrf52840_zmk.conf` for the SoC variant)?

### Step 2 — Verify CI workflow supports out-of-tree board extensions

Check whether `build-user-config.yml@main` passes `ZMK_EXTRA_MODULES` in a way that
allows out-of-tree `.zmk.yml` extensions for Zephyr-native boards (not just full
out-of-tree boards):

- https://github.com/zmkfirmware/zmk/blob/main/.github/workflows/build-user-config.yml

If supported: proceed with Steps 3–5 below.  
If not: fall back to a manual CI workflow (document in this plan before implementing).

### Step 3 — Write the ZMK extension files

Create two files under `config/boards/arm/nrf52840_mdk_usb_dongle/`:

**`nrf52840_mdk_usb_dongle.zmk.yml`**
```yaml
file_format: "1"
id: nrf52840_mdk_usb_dongle
name: Makerdiary nRF52840 MDK USB Dongle
url: https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle/
variants:
  - id: zmk
    features:
      - usb
      - ble
```
*(exact schema to be confirmed from Step 1)*

**`nrf52840_mdk_usb_dongle_nrf52840_zmk.conf`** (or `_zmk.conf` — confirm naming):
```
CONFIG_ZMK_USB=y
CONFIG_ZMK_BLE=y
CONFIG_USB_DEVICE_REMOTE_WAKEUP=n
```

### Step 4 — Update shield and build config

1. **`build.yaml`** — change dongle board from `nrf52840dongle//zmk` to
   `nrf52840_mdk_usb_dongle//zmk`

2. **`totem_dongle.zmk.yml`** — change `requires: [nrf52840dongle]` to
   `requires: [nrf52840_mdk_usb_dongle]`

3. **`totem_dongle.overlay`** — remove the workaround LED overrides and storage
   partition fix (no longer needed when building against the correct board)

4. **`SETUP_NOTES.md`** — update build target table

### Step 5 — Push and verify CI

Run `push-to-github.ps1` and confirm all 4 GitHub Actions builds pass with
`nrf52840_mdk_usb_dongle//zmk` as the dongle target.

### Step 6 — Flash and hardware test

1. Enter UF2 bootloader on Makerdiary dongle (hold reset or double-tap)
2. Copy `totem_dongle-nrf52840_mdk_usb_dongle.uf2` to the USB drive that appears
3. Dongle should enumerate as USB HID keyboard "TOTEM"
4. Flash `totem_left_peripheral` → left XIAO BLE
5. Flash `totem_right` → right XIAO BLE
6. Power all three — they pair automatically on first boot

---

## 7. Risk register (revised)

| Risk | Likelihood | Mitigation |
|---|---|---|
| CI doesn't pick up out-of-tree `.zmk.yml` extensions for Zephyr-native boards | Medium | Confirm in Step 2; fall back to manual workflow if needed |
| `.zmk.yml` variant schema differs from assumption — wrong field names fail silently | Low | Verify against a known working ZMK extension in Step 1 |
| Zephyr upstream MDK dongle DTS has a bug or is outdated | Low | Board has been in Zephyr tree since 2022; low risk |
| UF2 reset sequence differs from PCA10059 | Low | Confirmed by Makerdiary wiki; double-tap reset is standard |
| ~~Full HWMv2 port needed~~ | ~~High~~ | **Resolved** — Zephyr already provides the full board definition |
| ~~DTS porting errors from tungd/corne-mdk~~ | ~~Medium~~ | **Resolved** — upstream Zephyr DTS used instead |

---

## 8. Reference index

| Source | URL | Used for |
|---|---|---|
| ZMK Zephyr 4.1 blog | https://zmk.dev/blog/2025/12/09/zephyr-4-1 | `//zmk` variant spec, `.zmk.yml` format |
| ZMK `build-user-config.yml` | https://github.com/zmkfirmware/zmk/blob/main/.github/workflows/build-user-config.yml | CI extra modules behaviour |
| ZMK `nrf52840dongle` board | https://github.com/zmkfirmware/zmk/tree/main/app/boards/arm/nrf52840dongle | Reference `.zmk.yml` and conf for a dongle board |
| Zephyr upstream MDK USB Dongle board ⭐ | https://github.com/zephyrproject-rtos/zephyr/tree/main/boards/makerdiary/nrf52840_mdk_usb_dongle | **Authoritative HWMv2 board definition** — confirmed present |
| Makerdiary MDK USB Dongle wiki | https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle/ | UF2 flash layout, reset procedure |
| `tungd/corne-mdk` *(superseded)* | https://github.com/tungd/corne-mdk | Prior art — HWMv1, no longer needed as reference |
| `kemonine/keyboard` MDK attempt | https://git.kemonine.info/kemonine/keyboard/commit/86ea1fa15095ed8f44fcf8e82de6a593df48e785 | Prior art (outcome unknown) |

---

## 9. Areas requiring further definition (revised)

Items 1, 4 resolved by Zephyr upstream inspection.  Remaining open items:

1. **`.zmk.yml` variant descriptor exact schema** — field names and required vs optional
   entries need to be confirmed against an existing ZMK extension for a Zephyr-native
   board.  The `nrf52840dongle` ZMK tree entry is the best reference.

2. **Whether `build-user-config.yml` supports out-of-tree `.zmk.yml` extensions** —
   the single remaining high-risk unknown.  Must be confirmed before writing files.
   If not supported, the fallback is a manual `build.yml` workflow.

3. **Conf file naming convention for SoC variants** — the Makerdiary board targets
   the `nrf52840` SoC variant.  The conf file may need to be named
   `nrf52840_mdk_usb_dongle_nrf52840_zmk.conf` rather than just `_zmk.conf`.
   Confirm from the ZMK `nrf52840dongle` example.

~~4. Makerdiary DTS source~~ — **Resolved.** Zephyr upstream at
`boards/makerdiary/nrf52840_mdk_usb_dongle/` confirmed present and in HWMv2 format.

~~5. Bootloader reset behaviour~~ — **Resolved.** UF2 memory layout confirmed from
Makerdiary wiki; Application region `0x1000–0xf3fff` confirmed safe; bootloader at
`0xf4000` is protected by the UF2 protocol.

---

*Plan created: 2026-06-28 | Revised: 2026-06-28 | Author: Claude (Cowork) | Repo: BelongaGezza/zmk-config-totem*
