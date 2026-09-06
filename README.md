# mac-dotfiles-aerospace

## AeroSpace + SketchyBar + Ghostty + Starship + Neovim

####[中文](README_CN.md) | [English](README.md)

These are my personal macOS dotfiles, which I have been using and continuously refining over time.

The overall theme and interaction design remain centered around **native macOS aesthetics, minimal distraction, keyboard-first operation, automatic window placement, and a streamlined terminal workflow**.

Most of the configuration is inspired by or adapted from excellent community projects. I mainly modified, simplified, and recombined them to fit my own workflow. The goal remains unchanged:

> **Build a clean, efficient, predictable macOS environment with as few workflow interruptions as possible.**

![Desktop](readmefiles/insert.png)


---

## Major Update — 2026.09

1. AeroSpace now launches JankyBorders automatically on startup

2. Ghostty is now the primary terminal

3. SketchyBar

## 4. Native macOS App Menu


**Click the current App label to open the native macOS menu for the active application directly from SketchyBar.**

![Desktop](readmefiles/insert2.png)

Supported features:

- Top-level menus
- Submenus
- Disabled menu items
- Execute native menu commands by clicking
- Automatically closes when the mouse leaves the popup

This means that even if the native macOS menu bar is hidden, the active application's menu can still be accessed through SketchyBar.

To hide the native menu bar:

```text
System Settings
→ Control Center
→ Automatically hide and show the menu bar
→ Always
```

---

## 5. Music Control

The music control logic from the original README is still retained.

| Action | Function |
| --- | --- |
| Left click | Play / Pause |
| Right click | Next track |
| `Ctrl + Right click` | Previous track |

Current active player:

```text
Apple Music
```

`plugins/now_playing.sh` still contains support code for Spotify and MPD / `rmpc`.

To switch to Spotify, edit:

```text
~/.config/sketchybar/plugins/now_playing.sh
```

Disable:

```bash
get_apple_music_info
process_player_info
```

And enable:

```bash
get_spotify_info
process_player_info
```

6. YouTube Music

The repository still includes a separate YouTube Music item / plugin.

Client:

https://github.com/th-ch/youtube-music

After enabling the API Server, replace this line in `sketchybarrc`:

```bash
source "$ITEM_DIR/now_playing.sh"
```

with:

```bash
source "$ITEM_DIR/youtube-music.sh"
```

YouTube Music is not enabled by default, so it is not included in the minimal Homebrew installation list.

---

 7. Weather

Current default:

```bash
script="$PLUGIN_DIR/weather_baidu.sh"
```

The following weather providers are retained:

```text
Baidu Weather
NMC
Open-Meteo
```

Configure them in:

```text
~/.config/sketchybar/settings.sh
```

For example:

```bash
WEATHER_BAIDU_QUERY="上海闵行天气"
WEATHER_BAIDU_SRCID="4982"
```

NMC:

```bash
WEATHER_NMC_STATIONID="HIieJ"
```

Open-Meteo:

```bash
WEATHER_METEO_LATITUDE=30.2416
WEATHER_METEO_LONGITUDE=120.1189
```

---

## 8. Added Reminders Plugin

The current Reminders widget reads from:

```text
Inbox
```

and displays one incomplete reminder.

`Ctrl + Left Click`:

```text
Complete the currently displayed Reminder
```

`Ctrl + Right Click`:

```text
Open Reminders.app
```

---

 9. App Icons

Available through Homebrew:

```bash
brew install --cask font-sketchybar-app-font
```

---

# Installation

## 0. System prerequisites

It is recommended to install the Xcode Command Line Tools first:

```bash
xcode-select --install
```

They provide Git, Clang, and other macOS development tools, avoiding the need to install a full GCC toolchain just for Neovim / Tree-sitter.

Before using SketchyBar / AeroSpace, make sure the following option is enabled:

```text
System Settings
→ Desktop & Dock
→ Displays have separate Spaces
```

---

## 1. Install from Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Formulae

```bash
brew tap FelixKratz/formulae

brew install \
  sketchybar \
  borders \
  jq \
  starship \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zsh-completions
```

### Casks / Fonts

```bash
brew install --cask \
  nikitabobko/tap/aerospace \
  ghostty \
  font-hack-nerd-font \
  font-jetbrains-mono-nerd-font \
  font-sketchybar-app-font \
  sf-symbols
```

### Optional: Karabiner

Only required if you use the Hyper Layer:

```bash
brew install --cask karabiner-elements
```

---

### Optional: Neovim

The repository contains a complete Neovim configuration.

Minimum installation:

```bash
brew install neovim
```

To fully use Telescope, the native fzf extension, and Markdown Preview in the current Neovim configuration, the following packages are also recommended:

```bash
brew install \
  fd \
  ripgrep \
  cmake \
  node \
  yarn
```

## 2. Clone

**Remember to back up your existing configuration beforehand.**

```bash
git clone https://github.com/OthinusG/mac-dotfiles.git ~/mac-dotfiles && \
rm -rf ~/.config && \
cp -R ~/mac-dotfiles/.config ~/.config && \
cp ~/mac-dotfiles/.aerospace.toml ~/.aerospace.toml && \
cp ~/mac-dotfiles/.zshrc ~/.zshrc && \
cp ~/mac-dotfiles/.zprofile ~/.zprofile
```


---

# Start

## SketchyBar

```bash
brew services start sketchybar
```

Reload:

```bash
sketchybar --reload
```

---

## AeroSpace

The configuration already contains:

```toml
start-at-login = true
```

Simply launch AeroSpace.app normally.

AeroSpace will automatically run:

```text
borders
```

---

# Per-machine Settings

After copying the configuration, check at least the following settings.

---

## 1. Display names

The current `.aerospace.toml` contains:

```text
HDMI2.1
PHL 288E2
```

Check the displays on your own machine:

```bash
aerospace list-monitors
```

Then modify:

```toml
[gaps]
outer.top = [
  { monitor."YOUR DISPLAY" = 3 },
  3
]
```

---

## 2. Network interface

Current value:

```bash
INTERFACE="en1"
```

File:

```text
~/.config/sketchybar/plugins/network_rates.sh
```

Check available interfaces:

```bash
networksetup -listallhardwareports
```

Then change it according to your machine:

```text
en0
en1
...
```

---

## 3. Weather

File:

```text
~/.config/sketchybar/settings.sh
```

Modify:

```bash
WEATHER_BAIDU_QUERY
WEATHER_BAIDU_SRCID
WEATHER_NMC_STATIONID
WEATHER_METEO_LATITUDE
WEATHER_METEO_LONGITUDE
```

---

## 4. Proxy

The current proxy port in `.zshrc` is:

```text
127.0.0.1:7897
```

If Clash / Shadowrocket / Mihomo uses a different port, modify:

```bash
proxy() {
    ...
}
```

---

# References / Credits

Thanks to the following projects and configuration authors:

- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [JankyBorders](https://github.com/FelixKratz/JankyBorders)
- [Ghostty](https://ghostty.org/)
- [Starship](https://starship.rs/)
- [Herdr](https://herdr.dev/)
- [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font)
- [QianSong1/wezterm-config](https://github.com/QianSong1/wezterm-config)
- [clear668866x6/nvim](https://github.com/clear668866x6/nvim)
- [patricorgi/dotfiles](https://github.com/patricorgi/dotfiles)
- [manishprivet/.dotfiles](https://github.com/manishprivet/.dotfiles)
- [sergii-dudar/dotfiles](https://github.com/sergii-dudar/dotfiles)
- [Sinjhin/SketchyMenu](https://github.com/Sinjhin/SketchyMenu)
- [th-ch/youtube-music](https://github.com/th-ch/youtube-music)

Original reference video:

https://www.youtube.com/watch?v=e34qllePuoc

---

## Disclaimer

These are personal dotfiles, not a plug-and-play macOS distribution.

Some settings are intentionally opinionated and hardware-specific. Read the configuration before copying it and keep only the parts that fit your own workflow.
