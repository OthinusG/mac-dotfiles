# mac-dotfiles
## aerospace + sketchybar + borders + karabiner + wezterm + starship + nvim
自用mac-tahoe dotfiles，全都是从别人那里抄的，略微修改
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert.png)
# Install
1. Install homebrew and brew install packages listed down;
2. Backup your own config files,
3. Download config files and paste overlay file,
4. (Optional) Use karabiner to modify the function of the caps key,
5. (Optional) Modify your weather location: `/Users/**USER_NAME**/.config/sketchybar/settings.sh`, change `WEATHER_BAIDU_QUERY="上海闵行天气"` to the location name of your area.
# 安装
1. 安装 Homebrew 和用 Brew 安装下列包；
2. 备份您自己的配置文件；
3. 下载配置文件并粘贴覆盖文件；
4. （可选）利用karabiner修改caps键功能。
5. （可选）修改天气位置：`/Users/**用户名**/.config/sketchybar/settings.sh`, 把`WEATHER_BAIDU_QUERY="上海闵行天气"`改为自己区域的位置名称。
# homebrew
`brew tap FelixKratz/formulae`
`brew install borders btop ca-certificates fzf git glow lua neofetch neovim node nowplaying-cli gromgit/fuse/ntfs-3g-mac pandoc pipx python3 sketchybar switchaudio-osx wget zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting gcc npm git llvm fd starship`

`brew install --cask nikitabobko/tap/aerospace applite font-hack-nerd-font font-maple-mono font-sketchybar-app-font linearmouse maccy mounty qlmarkdown sf-symbolsb wezterm mediosz/tap/swipeaerospace corelocationcli`

# karabiner
`karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/OthinusG/capslox-karabiner/refs/heads/main/capslox-karabiner.json`

#### Ref
https://github.com/QianSong1/wezterm-config?tab=readme-ov-file
https://www.youtube.com/watch?v=e34qllePuoc
https://github.com/patricorgi/dotfiles
https://github.com/clear668866x6/nvim?tab=readme-ov-file
https://github.com/manishprivet/.dotfiles/tree/main
