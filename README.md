# 💔 SybauJokeVirus

> A Windows prank script that fades in the Sybau image, plays your custom audio, then unleashes 8 real GDI screen effects for 45 seconds before shutting the PC down normally.  
> **Zero damage. No files modified. No system settings changed. PC turns back on fine.**

---

## 📸 Preview

The script opens a small **500×500 borderless window** centred on the screen showing your custom image. While the image pulses, 8 real Windows GDI effects go absolutely insane on the entire screen simultaneously, paired with custom audio. After 45 seconds the PC does a normal shutdown.

---

## ⚠️ Disclaimer

This is a **harmless prank** for friends. No files are deleted, no registry is modified, no malware is installed. The GDI effects are 100% temporary — they vanish the instant the screen redraws. The shutdown is a standard Windows `/s` shutdown that the victim can recover from by just pressing the power button.

**Only use this on people who will find it funny. Do not use maliciously.**

---

## 📁 Folder Structure

```
sybau_virus/
├── sybau_virus.py       ← main script
├── sybau.png            ← your custom image (replace with anything)
├── ltg-sybau.mp3        ← audio that plays when image fades in
├── byebyte.wav          ← looping chaos audio during GDI effects (optional, must be .wav)
├── build.bat            ← compiles to svchost.exe
└── README.md
```

---

## 🚀 How to Run

### Option A — Run with Python directly

**1. Install requirements**
```bash
pip install pygame pillow numpy
```

**2. Run**
```bash
python sybau_virus.py
```

---

### Option B — Compile to EXE (recommended for pranking)

Just double-click `build.bat`. It will:
- Auto-install all dependencies including PyInstaller
- Compile everything into a single `dist/svchost.exe`
- Copy your assets next to the exe automatically

```
dist/
├── svchost.exe       ← send this to your victim
├── sybau.png
├── ltg-sybau.mp3
└── byebyte.wav
```

> The exe is named `svchost.exe` to blend in and look suspicious 😈

---

## ⏱️ Timeline

| Time | What Happens |
|------|-------------|
| `0s` | Small borderless window appears centre-screen, `sybau.png` fades in |
| `~2s` | `ltg-sybau.mp3` starts playing |
| `~4s` | All 8 GDI effects begin cycling on the **entire screen** + `byebyte.wav` joins |
| `~49s` | GDI effects stop, window closes |
| `~50s` | 💀 PC shuts down (normal shutdown, user can turn back on) |

---

## 🎨 GDI Effects

These effects draw directly onto the **real Windows desktop DC** via `ctypes`/Win32 — meaning they affect the **entire screen**, not just the window. They cycle randomly every few seconds.

| # | Effect | Description |
|---|--------|-------------|
| 1 | **Screen Inversion** | Full colour flip + random rect inversions |
| 2 | **Sine Wobble** | Every horizontal strip shifts by a sine wave |
| 3 | **Zoom Tunnel** | Screen shrinks into itself in layered rings |
| 4 | **Rotation Chunks** | Screen split into tiles, each randomly flipped/rotated |
| 5 | **Screen Swirl** | Concentric rings warp in alternating directions |
| 6 | **Static Noise** | Random grayscale blocks smashed across the screen |
| 7 | **Vertical Flip Strips** | Alternating vertical strips flipped upside-down |
| 8 | **Kaleidoscope** | Half/quarter screen mirrored onto itself |

---

## 🔊 Audio

| File | Role |
|------|------|
| `ltg-sybau.mp3` | Plays once when the image fades in. Streamed via `pygame.mixer.music`. Supports MP3/WAV/OGG. |
| `byebyte.wav` | Loops during the GDI chaos phase. **Must be a `.wav` file** — pygame cannot load MP3 as a Sound object. |

**Don't have a `byebyte.wav`?** The script auto-generates a glitchy bytebeat fallback so it still works without one.

**Want a real byebyte?** Generate one free at https://bytebeat.bitforever.de/ and export as WAV, or convert any audio with [Audacity](https://www.audacityteam.org/) or VLC.

---

## 🛠️ Customisation

| Thing | How to Change |
|-------|--------------|
| **Image** | Replace `sybau.png` with any image. Rename it or update `IMAGE_FILE` in the script |
| **Intro audio** | Replace `ltg-sybau.mp3` with any MP3/WAV |
| **Chaos audio** | Replace `byebyte.wav` with any WAV |
| **Window size** | Change `WIN_W` and `WIN_H` at the top of the script |
| **GDI duration** | Change `1000` in `if self.frame > 1000` (frames × 45ms = seconds) |
| **Shutdown delay** | Change `/t 10` in the `subprocess.Popen` call (seconds before shutdown) |
| **Disable shutdown** | Comment out the `subprocess.Popen(["shutdown"...])` line |

---

## 📋 Requirements

- **Windows only** (GDI effects use `ctypes.windll` — Win32 API)
- Python 3.8+
- `pygame` — audio playback
- `pillow` — image loading and PIL effects inside the window
- `numpy` — pixel-level image manipulation for PIL effects

```bash
pip install pygame pillow numpy
```

---

## 🔨 Building the EXE

`build.bat` uses [PyInstaller](https://pyinstaller.org/) to bundle everything:

```bat
pyinstaller --onefile --noconsole --name "svchost" \
    --add-data "sybau.png;." \
    --add-data "ltg-sybau.mp3;." \
    --add-data "byebyte.wav;." \
    sybau_virus.py
```

The `--noconsole` flag hides the terminal window so nothing suspicious appears. The output is a single portable `.exe`.

> **Note:** Some antivirus software may flag PyInstaller-compiled executables as suspicious due to the packing method. This is a false positive — the code does nothing malicious.

---

## ❓ FAQ

**Q: Will this damage the victim's PC?**  
A: No. GDI effects are purely visual and temporary. The shutdown is a standard Windows shutdown — identical to clicking Start → Shut Down. No data is lost.

**Q: What if `byebyte.wav` is missing?**  
A: The script generates a bytebeat fallback automatically. It'll still sound chaotic.

**Q: Can I press ESC to stop it?**  
A: Yes — pressing `ESC` at any time closes the window and stops all effects and audio immediately. It won't cancel a shutdown that's already been triggered though (`shutdown /a` in cmd will do that).

**Q: How do I cancel the shutdown after it's triggered?**  
A: Open Command Prompt and run:
```cmd
shutdown /a
```

**Q: The exe gets flagged by antivirus — is it a virus?**  
A: No, it's PyInstaller packing. Add an exclusion or send the raw Python files + `build.bat` instead.

---

## 📜 License

This project is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)** license.

[![CC BY-NC-SA 4.0](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

You are free to:
- **Share** — copy and redistribute the material in any medium or format
- **Adapt** — remix, transform, and build upon the material

Under the following terms:
- **Attribution** — You must give appropriate credit and a link to this repo
- **NonCommercial** — You may not use this for commercial purposes
- **ShareAlike** — If you remix or build on this, you must distribute under the same license

See the full license at: https://creativecommons.org/licenses/by-nc-sa/4.0/

---

<div align="center">
  <b>💔 SYBAU 💔</b>
</div>
