# TOTEM Keymap User Guide

Custom ZMK firmware for the [TOTEM](https://github.com/GEIGEIGEIST/totem) 38-key split keyboard (Seeed XIAO BLE).

This guide covers every layer, how to reach it, and how modifiers, combos, Mac mode, multi-host Bluetooth switching, and the USB dongle work.

---

## Table of contents

1. [Physical layout](#physical-layout)
2. [Layers at a glance](#layers-at-a-glance)
3. [Base layer](#base-layer)
4. [Navigation layer (NAV)](#navigation-layer-nav)
5. [Symbol layer (SYM)](#symbol-layer-sym)
6. [Adjust layer (ADJ)](#adjust-layer-adj)
7. [Mac mode layer (MAC)](#mac-mode-layer-mac)
8. [Home row modifiers (mod-tap)](#home-row-modifiers-mod-tap)
9. [Combos](#combos)
10. [Layer access quick reference](#layer-access-quick-reference)
11. [Windows vs macOS](#windows-vs-macos)
12. [Operating modes](#operating-modes)
13. [Building and flashing firmware](#building-and-flashing-firmware)
14. [Multi-host Bluetooth pairing](#multi-host-bluetooth-pairing)
15. [ZMK Studio — live keymap editing](#zmk-studio--live-keymap-editing)
16. [Troubleshooting](#troubleshooting)

---

## Physical layout

The TOTEM is a column-staggered split: **19 keys per half**, **38 keys total**.

```
LEFT HALF                              RIGHT HALF
┌───┬───┬───┬───┬───┐                  ┌───┬───┬───┬───┬───┐
│ Q │ W │ E │ R │ T │                  │ Y │ U │ I │ O │ P │
├───┼───┼───┼───┼───┤                  ├───┼───┼───┼───┼───┤
│A/G│S/A│D/C│F/S│ G │                  │ H │J/S│K/C│L/A│;/G│
├───┼───┼───┼───┼───┤                  ├───┼───┼───┼───┼───┤
│Esc│ Z │ X │ C │ V │ B │              │ N │ M │ , │ . │ / │ \ │
└───┴───┴───┴───┴───┴───┘              └───┴───┴───┴───┴───┴───┘
          │Del│Tab│Spc│                  │Ent│Sym│Bsp│
          └───┴───┴───┘                  └───┴───┴───┘
```

**Legend (base layer):**

| Label | Meaning |
|-------|---------|
| `A/G` | Tap **A**, hold **GUI** (Win key on Windows, Cmd on macOS) |
| `S/A` | Tap **S**, hold **Alt** (Alt on Windows, Option on macOS) |
| `D/C` | Tap **D**, hold **Ctrl** |
| `F/S` | Tap **F**, hold **Shift** |
| `J/S` | Tap **J**, hold **Shift** |
| `K/C` | Tap **K**, hold **Ctrl** |
| `L/A` | Tap **L**, hold **Alt** |
| `;/G` | Tap **;**, hold **GUI** |
| `Tab` | Tap **Tab**, hold **NAV layer** |
| `Sym` | Tap **Esc**, hold **SYM layer** |

---

## Layers at a glance

| # | Name | Type | How to activate |
|---|------|------|-----------------|
| 0 | **BASE** | Default | Always on |
| 1 | **NAV** | Momentary | Hold **Tab** (left thumb, centre key) |
| 2 | **SYM** | Momentary | Hold **Esc** (right thumb, centre key) |
| 3 | **ADJ** | Momentary | Hold **Enter** while on NAV, or hold **middle-left thumb** while on SYM |
| 4 | **MAC** | **Toggle** | Tap **MAC TOG** on ADJ layer (stays on until tapped again) |

**Momentary** layers are active only while you hold the layer key.  
**Toggle** layers stay active across key presses until you toggle them off.

---

## Base layer

Default typing layer — **QWERTY** with home-row modifiers.

```
┌───┬───┬───┬───┬───┐                  ┌───┬───┬───┬───┬───┐
│ Q │ W │ E │ R │ T │                  │ Y │ U │ I │ O │ P │
├───┼───┼───┼───┼───┤                  ├───┼───┼───┼───┼───┤
│A/G│S/A│D/C│F/S│ G │                  │ H │J/S│K/C│L/A│;/G│
├───┼───┼───┼───┼───┼───┐          ┌───┼───┼───┼───┼───┼───┤
│Esc│ Z │ X │ C │ V │ B │          │ N │ M │ , │ . │ / │ \ │
└───┴───┴───┴───┴───┴───┘          └───┴───┴───┴───┴───┴───┘
          │Del│Tab│Spc│                  │Ent│Sym│Bsp│
          └───┴───┴───┘                  └───┴───┴───┘
```

### Thumb keys

| Key | Tap | Hold |
|-----|-----|------|
| Left inner | Delete | Delete |
| Left centre | Tab | **NAV layer** |
| Left outer | Space | Space |
| Right inner | Enter | Enter |
| Right centre | Esc | **SYM layer** |
| Right outer | Backspace | Backspace |

---

## Navigation layer (NAV)

**Activate:** hold **Tab** (left thumb centre).

```
┌─────┬────────┬────┬─────┬───┐              ┌───┬───┬───┬───┬───┐
│ Esc │BT Clear│ Up │  =  │ { │              │ } │ 7 │ 8 │ 9 │ + │
├─────┼────────┼────┼─────┼───┤              ├───┼───┼───┼───┼───┤
│Shift│  Left  │Down│Right│ [ │              │ ] │ 4 │ 5 │ 6 │ - │
├─────┼────────┼────┼─────┼───┼───┐      ┌───┼───┼───┼───┼───┼───┤
│     │  Del   │PgUp│Caps │PgDn│ ( │      │ ) │ 1 │ 2 │ 3 │ * │   │
└─────┴────────┴────┴─────┴───┴───┘      └───┴───┴───┴───┴───┴───┘
              │   │Tab │Spc│                  │ADJ│ 0 │   │
              └───┴────┴───┘                  └───┴───┴───┘
```

Keys not listed are transparent and pass through to BASE.

---

## Symbol layer (SYM)

**Activate:** hold **Esc** (right thumb centre).

```
┌───┬───┬───┬───┬───┐                  ┌───┬───┬───┬───┬───┐
│ ! │ @ │ # │ $ │ % │                  │ ^ │ & │ * │ ( │ ) │
├───┼───┼───┼───┼───┤                  ├───┼───┼───┼───┼───┤
│ ` │ - │ _ │ = │ [ │                  │ ] │ \ │ ; │ ' │ " │
├───┼───┼───┼───┼───┼───┐          ┌───┼───┼───┼───┼───┼───┤
│ £ │   │   │   │   │   │          │Vol-│Vol+│Prv│Nxt│ | │   │
└───┴───┴───┴───┴───┴───┘          └───┴───┴───┴───┴───┴───┘
              │   │ADJ│   │                  │Mut│P/P│   │
              └───┴───┴───┘                  └───┴───┴───┘
```

`£` is a dedicated key — no Shift needed.  Right thumb `ADJ` reaches the adjust layer.

---

## Adjust layer (ADJ)

**Activate (either path):**
- Hold **Tab** → NAV → hold **Enter**, or
- Hold **Esc** → SYM → hold **middle-left thumb**

```
┌───────┬─────────┬─────────┬─────────┬───┐          ┌───────┬───┬───┬───┬────┐
│ Reset │ BT Clear│ OUT TOG │ MAC TOG │   │          │Studio │F7 │F8 │F9 │F12 │
├───────┼─────────┼─────────┼─────────┼───┤          ├───────┼───┼───┼───┼────┤
│Bootldr│ BT Next │         │         │   │          │       │F4 │F5 │F6 │F11 │
├───────┼─────────┼─────────┼─────────┼───┼───┐  ┌───┼───────┼───┼───┼───┼────┤
│       │         │ BT Prev │         │   │   │  │   │       │F1 │F2 │F3 │F10 │
└───────┴─────────┴─────────┴─────────┴───┴───┘  └───┴───────┴───┴───┴───┴────┘
```

### ADJ key reference

| Key | Action |
|-----|--------|
| **Reset** | Reboot firmware |
| **Bootloader** | Enter UF2 bootloader for flashing |
| **BT Clear** | Clear current BT profile's pairing |
| **BT Next** | Next Bluetooth host profile (cycles 0 → 4) |
| **BT Prev** | Previous Bluetooth host profile (cycles 4 → 0) |
| **OUT TOG** | Toggle HID output: USB ↔ Bluetooth |
| **MAC TOG** | Toggle Mac modifier layout (see below) |
| **Studio** | Unlock ZMK Studio for live keymap editing (top-right inner key) |
| **F1–F12** | Function keys across the right half |

---

## Mac mode layer (MAC)

**Toggle on/off:** ADJ → tap **MAC TOG**.  Stays active until tapped again.

Swaps **GUI** and **Ctrl** on the home-row mod-taps so Cmd lands where you expect it on macOS.

| Key | MAC **off** (Windows) | MAC **on** (macOS) |
|-----|-----------------------|--------------------|
| **A** | GUI (Win/Cmd) | **Ctrl** |
| **D** | Ctrl | **GUI (Cmd)** |
| **K** | Ctrl | **GUI (Cmd)** |
| **;** | GUI (Win/Cmd) | **Ctrl** |
| S, F, J, L | Alt / Shift (unchanged) | Alt / Shift (unchanged) |

---

## Home row modifiers (mod-tap)

| Concept | Behaviour |
|---------|-----------|
| **Tap** (quick press and release) | Sends the letter |
| **Hold** (≥170 ms) | Acts as the modifier |
| **Tap preferred** | Ambiguous presses favour the letter |
| **Global quick-tap** | Another key pressed while holding a mod-tap fires the modifier immediately |

---

## Combos

| Combo | Keys | Output | Timeout |
|-------|------|--------|---------|
| **Esc** | **Q** + **W** | Esc | 50 ms |

---

## Layer access quick reference

```
BASE ──hold Tab──────────────► NAV ──hold Enter────► ADJ
BASE ──hold Sym/Esc──────────► SYM ──hold mid-thumb─► ADJ
ADJ  ──tap MAC TOG───────────► MAC (toggle, persists)
```

| I want to… | Do this |
|------------|---------|
| Arrow keys / numpad | Hold **Tab** |
| Symbols / £ / media | Hold **Sym** (right thumb centre) |
| Reset / BT / F-keys | **Tab** + hold **Enter**, or **Sym** + hold mid-left thumb |
| Switch Bluetooth host | ADJ → **BT Next** / **BT Prev** |
| Toggle USB vs BT output | ADJ → **OUT TOG** |
| Toggle Mac/Win modifiers | ADJ → **MAC TOG** |
| Remap keys live (Studio) | ADJ → **Studio** (top-right inner key), then use the Studio web app |
| Alternative Esc | Press **Q** + **W** together |

---

## Windows vs macOS

| Topic | Detail |
|-------|--------|
| **GUI key** | Windows key on PC, Command on Mac — same ZMK keycode |
| **Alt key** | Alt on Windows, Option on Mac |
| **Default layout** | Optimised for Windows (Ctrl on D/K) |
| **Mac mode** | Toggle when you want Cmd on D/K |
| **UK £** | Dedicated key on SYM; set host OS to English (UK) for other symbols |
| **USB vs Bluetooth** | **OUT TOG** switches output; USB gives lowest latency |

---

## Operating modes

This firmware supports three operating modes.  Each requires its own set of firmware files.

### Mode 1 — USB Dongle (lowest latency, no host Bluetooth required)

A Makerdiary nRF52840 MDK USB Dongle plugs into the laptop and acts as the keyboard's USB interface.  Both halves talk to the dongle over BLE; the dongle talks to the host over USB.  No Bluetooth driver or pairing is needed on the host side.

**Flash targets:**

| Firmware | Board | Flash to |
|----------|-------|---------|
| `totem_dongle` | nRF52840 MDK USB Dongle | USB Dongle |
| `totem_left_peripheral` | Seeed XIAO BLE | Left half |
| `totem_right` | Seeed XIAO BLE | Right half |

**First-time pairing:**
1. Flash all three pieces of firmware.
2. Insert the dongle into USB.
3. Power on both halves — they auto-pair to the dongle (no host action needed).
4. The host sees a standard USB HID keyboard named **TOTEM**.

If a half won't pair, enter ADJ on that half, press **BT Clear**, power-cycle, and try again.

**Switching between laptops in dongle mode:** move the physical dongle.  The halves remember only the dongle; swap the dongle to the other machine and you're done.

---

### Mode 2 — Left half as central (Bluetooth to one host)

The left half connects directly to the host via Bluetooth.  No dongle needed.

**Flash targets:**

| Firmware | Board | Flash to |
|----------|-------|---------|
| `totem_left` | Seeed XIAO BLE | Left half |
| `totem_right` | Seeed XIAO BLE | Right half |

---

### Mode 3+ — Left half as central (multiple Bluetooth hosts)

Same firmware as Mode 2.  ZMK supports up to **5 Bluetooth host profiles** (slots 0–4), switched from the ADJ layer.

**Pairing a new host on an unused profile:**
1. Enter ADJ (hold Tab → hold Enter, or hold Sym → hold mid-left thumb).
2. Press **BT Next** until you reach an unused slot.
3. Put the new host into Bluetooth pairing mode — it will appear as **TOTEM**.
4. Pair as normal.

**Switching hosts day-to-day:**
- Press **BT Next** / **BT Prev** on ADJ to cycle profiles.  Connection to the selected host is automatic.

**Clearing a profile:**
- Navigate to that profile slot, then press **BT Clear** on ADJ.  Re-pair to assign a new host to that slot.

---

### Choosing a mode

| Scenario | Recommended mode |
|----------|-----------------|
| Single laptop, want USB reliability | **Mode 1** (dongle) |
| Moving dongle between machines | **Mode 1** (move dongle) |
| Multiple hosts without carrying a dongle | **Mode 2/3+** (BT profiles) |
| Mac + Windows multi-host | **Mode 2/3+** + **MAC TOG** per host |

**You cannot switch modes at runtime** — each mode requires different firmware on the left half (and dongle).  The right half firmware is the same for all modes.

---

## Building and flashing firmware

### Via GitHub Actions (recommended)

1. Push your changes to GitHub.
2. Open your repo → **Actions** tab → wait for the build.
3. Download **firmware.zip** from the run artefacts.
4. The zip contains one `.uf2` per build target.

### Flashing XIAO BLE halves

1. Plug in via USB.
2. Double-press the reset button — a drive named **XIAO-SENSE** or similar appears.
3. Drag the matching `.uf2` onto the drive:
   - `totem_left-seeeduino_xiao_ble-zmk.uf2` → left half (Mode 2/3+)
   - `totem_left_peripheral-seeeduino_xiao_ble-zmk.uf2` → left half (Mode 1)
   - `totem_right-seeeduino_xiao_ble-zmk.uf2` → right half (all modes)
4. The drive unmounts and the half reboots automatically.

### Flashing the nRF52840 MDK USB Dongle (Mode 1 only)

1. Hold the reset button while inserting into USB — a drive named **MDK-DONGLE** appears.
2. Drag `totem_dongle-nrf52840_mdk_usb_dongle-zmk.uf2` onto the drive.
3. The drive unmounts and the dongle reboots.

Flash both halves after any keymap change, even if only one layer changed — the keymap is compiled into the central (left half or dongle) only, but peripherals need to be reset for clean re-pairing.

---

## Multi-host Bluetooth pairing

ZMK maintains up to 5 named BT profiles.  Each profile stores exactly one paired host.

| ADJ key | Action |
|---------|--------|
| **BT Next** | Move to the next profile slot |
| **BT Prev** | Move to the previous profile slot |
| **BT Clear** | Clear the current slot's pairing |
| **OUT TOG** | Toggle USB ↔ BLE HID output |

The active profile is stored in flash and survives power-off.

---

## ZMK Studio — live keymap editing

ZMK Studio lets you remap keys in real-time from a browser without reflashing firmware. Changes are written to the keyboard's flash and persist across power cycles.

**Requirements:** a USB connection to the central (dongle in Mode 1, left half in Mode 2/3+). ZMK Studio does not work over Bluetooth.

### Connecting

1. Connect the central to your PC via USB.
2. Open **https://zmkfirmware.dev/studio/** in Chrome or Edge (other browsers unsupported).
3. Click **Connect** — select the TOTEM device from the browser's serial port picker.
4. The keyboard will appear as **locked**. You must unlock it from the keyboard itself (see below).

### Unlocking the keyboard

The **Studio** key on ADJ sends `studio_unlock`, which authorises the Studio session.

**Key combo:** hold **Tab** (NAV) → hold **Enter** (ADJ) → tap the key in the **Y column, top row** (innermost top-right key — where Y is on the base layer).

Alternatively via SYM: hold **Esc** (SYM) → hold **left thumb inner** (ADJ) → tap the same key.

Once unlocked, the Studio web app will display the full TOTEM layout and allow per-key remapping.

### What Studio can and can't do

| Supported | Not supported |
|-----------|--------------|
| Remap any key on any layer | Add or remove layers |
| Set mod-taps and layer-taps | Change combos or behaviours |
| Switch between layouts | Modify BLE/USB config |
| Save keymaps to flash | Replace the physical layout |

Studio edits are stored separately from the compiled keymap. If you reflash firmware, Studio customisations are preserved unless you also clear settings storage (ADJ → Reset does not clear storage; a full erase would).

### Reverting Studio changes

To discard all Studio customisations and revert to the compiled keymap, enter the ZMK Studio web app and use **Reset to default** — or hold **Reset** on ADJ to reboot, which reloads the compiled defaults if Studio storage is cleared.

---

## Troubleshooting

| Problem | Try |
|---------|-----|
| Letter prints instead of modifier | Hold the key slightly longer (>170 ms) |
| Mac shortcuts feel wrong | Toggle **MAC TOG** on ADJ |
| £ prints the wrong character | Set host keyboard layout to **English (UK)** |
| Layer appears stuck | Only **MAC** is a toggle — tap **MAC TOG** again to disable |
| Keyboard not connecting (BT) | ADJ → **BT Clear**, re-pair; or switch to USB with **OUT TOG** |
| Dongle mode: half not responding | ADJ on that half → **BT Clear**, power-cycle the half |
| Odd behaviour after firmware update | ADJ → **Reset** on both halves, or re-flash |
| BT profile shows wrong host | ADJ → **BT Clear** on that slot, re-pair |
| Studio: keyboard not found in browser | Use Chrome or Edge; try a different USB cable; ensure central is connected (not just a half) |
| Studio: keyboard shows as locked | Press the ADJ **Studio** key (Y column, top row) with ADJ active |
| Studio: no serial port in picker | Check that `studio-rpc-usb-uart` firmware was flashed (built with Studio enabled in build.yaml) |

---

## Source files

| File | Purpose |
|------|---------|
| `config/totem.keymap` | Keymap — layers, combos, behaviours |
| `config/boards/shields/totem/totem.keymap` | Shield-default keymap (Colemak/German variant) |
| `config/totem.conf` | Build options |
| `build.yaml` | GitHub Actions build targets (all modes) |
| `SETUP_NOTES.md` | Flashing instructions, mode details, change log |

For ZMK keycode reference: [zmk.dev/docs/codes](https://zmk.dev/docs/codes)
