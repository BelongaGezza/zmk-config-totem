# TOTEM Keymap User Guide

Custom ZMK firmware for the [TOTEM](https://github.com/GEIGEIGEIST/totem) 38-key split keyboard (SEEEED XIAO BLE).

This guide describes every layer, how to reach it, and how modifiers, combos, and Mac mode work.

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
12. [Building and flashing firmware](#building-and-flashing-firmware)
13. [Bluetooth pairing](#bluetooth-pairing)
14. [Troubleshooting](#troubleshooting)

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
| `A/G` | Tap **A**, hold **GUI** (Win on Windows, Cmd on macOS) |
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

Multiple layers can be active at once. For example, with **Mac mode on**, the **MAC** layer sits on top of **BASE** and overrides only the home-row modifier keys.

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

### Outer pinky keys

| Key | Action |
|-----|--------|
| Far left (below Z) | Esc |
| Far right (below \\) | Backslash `\` |

### Common shortcuts (Windows mode, Mac mode **off**)

| Action | Keys |
|--------|------|
| Copy | Hold **D** (Ctrl) + tap **C** |
| Paste | Hold **D** (Ctrl) + tap **V** |
| Undo | Hold **D** (Ctrl) + tap **Z** |
| Select all | Hold **D** (Ctrl) + tap **A** |
| Save | Hold **D** (Ctrl) + tap **S** |
| Cmd-style on Mac host | Hold **A** (GUI/Cmd) + letter — works because macOS maps GUI to Command |

---

## Navigation layer (NAV)

**Activate:** hold **Tab** (left thumb centre).

```
┌─────┬────────┬────┬────┬───┐              ┌───┬───┬───┬───┬───┐
│ Esc │BT Clear│ Up │ =  │ { │              │ } │ 7 │ 8 │ 9 │ + │
├─────┼────────┼────┼────┼───┤              ├───┼───┼───┼───┼───┤
│Shift│  Left  │Down│Right│ [ │              │ ] │ 4 │ 5 │ 6 │ - │
├─────┼────────┼────┼────┼───┼───┐      ┌───┼───┼───┼───┼───┼───┤
│     │  Del   │PgUp│Caps│PgDn│ ( │      │ ) │ 1 │ 2 │ 3 │ * │   │
└─────┴────────┴────┴────┴───┴───┘      └───┴───┴───┴───┴───┴───┘
              │   │Tab│Spc│                  │ADJ│ 0 │   │
              └───┴───┴───┘                  └───┴───┴───┘
```

### Highlights

| Area | Keys |
|------|------|
| Arrows | Up / Down / Left / Right (centre-left) |
| Navigation | Page Up, Page Down, Delete, Caps Lock |
| Brackets | `{` `}` `[` `]` `(` `)` |
| Numpad | `0`–`9`, `+`, `-`, `*` (right side) |
| Bluetooth | **BT Clear** (top row, clears pairings) |
| Adjust | Hold **Enter** (right thumb) → **ADJ layer** |

Keys not listed above are transparent (`───`) and pass through to the layer below (BASE).

---

## Symbol layer (SYM)

**Activate:** hold **Esc** (right thumb centre).  
**Note:** tapping that key sends **Esc**; holding it opens symbols and media.

```
┌───┬───┬───┬───┬───┐                  ┌───┬───┬───┬───┬───┐
│ ! │ @ │ # │ $ │ % │                  │ ^ │ & │ * │ ( │ ) │
├───┼───┼───┼───┼───┤                  ├───┼───┼───┼───┼───┤
│ ` │ - │ _ │ = │ [ │                  │ ] │ \ │ ; │ ' │ " │
├───┼───┼───┼───┼───┼───┐          ┌───┼───┼───┼───┼───┼───┤
│ £ │   │   │   │   │   │          │   │Vol│Vol│Prv│Nxt│ | │
└───┴───┴───┴───┴───┴───┘          └───┴───┴───┴───┴───┴───┘
              │   │ADJ│   │                  │Mut│P/P│   │
              └───┴───┴───┘                  └───┴───┴───┘
```

### Symbol reference

| Key | Character / action |
|-----|-------------------|
| Top row | `!` `@` `#` `$` `%` `^` `&` `*` `(` `)` |
| Home row | `` ` `` `-` `_` `=` `[` `]` `\` `;` `'` `"` |
| Far left bottom | **£** (UK pound) |
| Right bottom | Volume down/up, Previous/Next track, `\|` |
| Right thumbs | Mute, Play/Pause |
| Middle-left thumb | Hold → **ADJ layer** |

`#` is available on the top row. **£** is a dedicated key on the bottom-left (no Shift needed).

---

## Adjust layer (ADJ)

**Activate (either path):**

1. Hold **Tab** → NAV layer → hold **Enter** (right thumb), or  
2. Hold **Esc** → SYM layer → hold **middle-left thumb**

```
┌───────┬─────────┬─────────┬─────────┬───┐          ┌───┬───┬───┬───┬────┐
│ Reset │ BT Clear│ OUT TOG │ MAC TOG │   │          │   │F7 │F8 │F9 │F12 │
├───────┼─────────┼─────────┼─────────┼───┤          ├───┼───┼───┼───┼────┤
│Bootldr│ BT Next │         │         │   │          │   │F4 │F5 │F6 │F11 │
├───────┼─────────┼─────────┼─────────┼───┼───┐  ┌───┼───┼───┼───┼───┼────┤
│       │         │ BT Prev │         │   │   │  │   │   │F1 │F2 │F3 │F10 │
└───────┴─────────┴─────────┴─────────┴───┴───┘  └───┴───┴───┴───┴───┴────┘
```

### Function keys

| Key | Action | Notes |
|-----|--------|-------|
| **Reset** | `&sys_reset` | Reboots the keyboard firmware |
| **Bootloader** | Bootloader mode | Double-tap reset alternative; for flashing UF2 |
| **BT Clear** | Clear all Bluetooth bonds | Re-pair afterwards |
| **BT Next** | Next Bluetooth profile | Cycle paired devices |
| **BT Prev** | Previous Bluetooth profile | Cycle paired devices |
| **OUT TOG** | Toggle USB / BLE output | Switch between USB and Bluetooth |
| **MAC TOG** | Toggle Mac mode | See [Mac mode](#mac-mode-layer-mac) |
| **F1–F12** | Function keys | Full F-key row across right half |

---

## Mac mode layer (MAC)

**Toggle on/off:** ADJ layer → tap **MAC TOG**.  
Stays active until you tap **MAC TOG** again.

Mac mode swaps **GUI** and **CTRL** on the four home-row mod-tap positions so editing shortcuts sit on the fingers you expect when moving between Windows and macOS.

### Modifier positions

| Key | Windows mode (MAC **off**) | Mac mode (MAC **on**) |
|-----|---------------------------|----------------------|
| **A** | GUI (Win / Cmd) | **Ctrl** |
| **D** | Ctrl | **GUI (Cmd)** |
| **K** | Ctrl | **GUI (Cmd)** |
| **;** | GUI (Win / Cmd) | **Ctrl** |
| S, F, J, L | Alt, Shift (unchanged) | Alt, Shift (unchanged) |

### When to use Mac mode

| Situation | Recommended setting |
|-----------|---------------------|
| Windows PC (primary) | **MAC off** — Ctrl on **D** and **K** for Ctrl+C, Ctrl+V, etc. |
| macOS | **MAC on** — Cmd on **D** and **K** for Cmd+C, Cmd+V, etc. |
| Mac but you prefer Cmd on **A** | **MAC off** — GUI on **A** already sends Command on macOS |

### Example shortcuts with Mac mode **on**

| Action | Keys |
|--------|------|
| Copy | Hold **D** (Cmd) + **C** |
| Paste | Hold **D** (Cmd) + **V** |
| Save | Hold **D** (Cmd) + **S** |
| Terminal Ctrl+C | Hold **A** (Ctrl) + **C** |

---

## Home row modifiers (mod-tap)

This keymap uses **mod-tap** (`&mt`), not ZMK **sticky keys** (`&sk`).

| Concept | Behaviour |
|---------|-----------|
| **Tap** (press and release quickly) | Sends the letter |
| **Hold** (press and hold ~170 ms) | Acts as the modifier |
| **Tap preferred** | If the press is ambiguous, the letter wins |
| **Global quick-tap** | Pressing another key while a mod-tap is held applies the modifier immediately — you do not need to wait for the hold timeout |

### Timing settings

| Setting | Value | Effect |
|---------|-------|--------|
| `tapping-term-ms` | 170 ms | Hold longer than this → modifier |
| `quick-tap-ms` | 100 ms | Window for quick double-taps |
| `flavor` | tap-preferred | Favours letters on ambiguous presses |

### This is not sticky keys

**Sticky keys** (`&sk`) latch a modifier after one press until the next key or a timeout.  
**Mod-tap** requires you to **hold** the home-row key for the modifier. There are no latched/sticky modifiers in this keymap.

---

## Combos

Combos fire when two (or more) keys are pressed within a short window.

| Combo | Keys | Output | Timeout |
|-------|------|--------|---------|
| **Esc combo** | **Q** + **W** (together) | Esc | 50 ms |

Useful when **Esc** on the thumb or pinky is awkward.

---

## Layer access quick reference

```
BASE ──hold Tab──────────────► NAV ──hold Enter────► ADJ
  │                              │
  │                              └── BT, arrows, numpad, F-keys via ADJ
  │
  └──hold Sym/Esc────────────► SYM ──hold mid-thumb──► ADJ
                                 │
                                 └── symbols, £, media

ADJ ──tap MAC TOG────────────► MAC (toggle, persists)
```

| I want to… | Do this |
|------------|---------|
| Type normally | Use **BASE** (default) |
| Arrow keys / numpad | Hold **Tab** |
| Symbols / £ / media | Hold **Sym** (right thumb centre) |
| Reset / Bluetooth / F-keys | **Tab** + hold **Enter**, or **Sym** + hold mid-left thumb |
| Toggle Mac/Win modifier layout | Enter **ADJ** → tap **MAC TOG** |
| Esc (alternative) | Press **Q** + **W** together |

---

## Windows vs macOS

| Topic | Detail |
|-------|--------|
| **GUI key** | Windows key on PC, Command on Mac — same firmware keycode |
| **Alt key** | Alt on Windows, Option on Mac |
| **Default layout** | Optimised for **Windows** (Ctrl on D/K) |
| **Mac mode** | Toggle when you want **Cmd on D/K** instead |
| **UK £** | Dedicated key on **SYM** layer; set host OS keyboard to **UK** for correct symbol mapping elsewhere |
| **USB vs Bluetooth** | **OUT TOG** on ADJ switches output; use USB for lowest latency on either OS |

---

## Building and flashing firmware

1. Edit `config/totem.keymap` locally.
2. Commit and push to your fork on GitHub.
3. Open your fork → **Actions** → wait for the build to finish.
4. Download the **firmware.zip** artifact.
5. Flash **each half** separately:
   - Plug in USB (or use UF2 bootloader).
   - Double-press the reset button on the XIAO.
   - A drive appears — drag the matching `.uf2` file:
     - `totem_left-seeeduino_xiao_ble-zmk.uf2` → **left** half
     - `totem_right-seeeduino_xiao_ble-zmk.uf2` → **right** half

Flash both halves after any keymap change.

---

## Bluetooth pairing

1. Enter **ADJ** (via NAV or SYM).
2. Tap **BT Clear** if you need to wipe old pairings.
3. Tap **BT Next** / **BT Prev** to select a profile slot.
4. Put the host device in Bluetooth pairing mode.
5. The keyboard should connect to the selected profile.

Use **OUT TOG** if you need to switch between USB and Bluetooth output.

---

## Troubleshooting

| Problem | Try |
|---------|-----|
| Letter prints when you wanted a modifier | Hold the key slightly longer (>170 ms), or use [global quick-tap](#home-row-modifiers-mod-tap) by pressing the letter while holding |
| Mac shortcuts feel wrong | Toggle **MAC TOG** on ADJ — see [Mac mode](#mac-mode-layer-mac) |
| £ prints wrong character | Set host keyboard layout to **English (UK)** |
| Layer stuck | Release all keys; toggle layers are only **MAC** — tap **MAC TOG** again to disable |
| Keyboard not connecting | **BT Clear**, re-pair; or use USB via **OUT TOG** |
| After firmware update, odd behaviour | **Reset** from ADJ, or re-flash both halves |

---

## Source files

| File | Purpose |
|------|---------|
| `config/totem.keymap` | Keymap (layers, combos, behaviours) |
| `config/totem.conf` | Build options |
| `build.yaml` | GitHub Actions build targets |

For ZMK keycode reference: [zmk.dev/docs/codes](https://zmk.dev/docs/codes)
