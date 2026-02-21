# 🌒 Dimmer

A macOS menu bar app that dims your screen beyond the system's minimum brightness. Useful for working in dark environments where even the lowest brightness setting is too bright.

## How It Works

Dimmer places a transparent black overlay window on top of your screen. Adjusting the overlay's opacity controls how much extra dimming is applied. The overlay is completely click-through, so you can interact with everything underneath normally.

## Usage

1. Launch Dimmer — a sun icon appears in your menu bar
2. Click the icon to open the dimming controls
3. Drag the slider to adjust the dimming level (0%–90%)
4. The setting is remembered across launches
5. Quit via the button in the popover

## Features

- Menu bar only app (no dock icon)
- Slider with 0%–90% dimming range
- Works across all Spaces/desktops
- Supports multiple displays
- Persists dimming level across launches

## Install

1. Download the latest `.dmg` from [Releases](https://github.com/MartinMoizard/Dimmer/releases)
2. Open the `.dmg` and drag Dimmer to your Applications folder
3. Launch Dimmer — macOS will show a warning because the app is not notarized
4. Open **System Settings > Privacy & Security**, scroll down to the Security section, and click **Open Anyway** next to the Dimmer message
5. Confirm by clicking **Open** in the dialog that appears

You only need to do this once. After that, Dimmer will open normally.

## Requirements

- macOS 26+
- Xcode 26.2+ to build from source

## Building

Open `Dimmer.xcodeproj` in Xcode and run (`Cmd+R`).

## Generating the App Icon

The app icon is generated programmatically via a Swift script. To regenerate all icon sizes:

```bash
swift generate_icon.swift
```

This produces all required sizes (16–1024px) directly into the asset catalog.

## License

MIT
