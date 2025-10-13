# mac-dotfiles
## aerospace + sketchybar + borders + karabiner + wezterm + starship + nvim
自用mac-tahoe dotfiles，全都是从别人那里抄的，略微修改，开启了hazeover，非焦点窗口亮度下降。
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert.png)
# Install
1. Install homebrew and brew install packages listed down;
2. Backup your own config files,
3. Download config files and paste overlay file,
4. (no use) Use karabiner to modify the function of the caps key.
5. (Optional) Modify your weather location: `/Users/**USER_NAME**/.config/sketchybar/settings.sh`, change `WEATHER_BAIDU_QUERY="上海闵行天气"` to the location name of your area.
6. (Optional) This music script supports Apple Music, Spotify, and YouTube Music. Spotify support is enabled by default.
   - **To enable Apple Music**: Edit the file `~/.config/sketchybar/plugins/now_playing.sh`. Comment out the line containing `get_spotify_info` and the `process_player_info` line immediately following it. Then, uncomment the line containing `get_apple_music_info` and its corresponding `process_player_info` line below it.
   - **To enable YouTube Music**:
     1. Use the YouTube Music client from: [youtube-music](https://github.com/th-ch/youtube-music)
     2. Ensure the listening port for the client is enabled.
     3. In your `sketchybarrc` file (e.g., `/Users/wqin/.config/sketchybar/sketchybarrc`), change the line `source "$ITEM_DIR/now_playing.sh"` to `source "$ITEM_DIR/youtube-music.sh"`.
# 安装说明
1. 安装 Homebrew 和用 Brew 安装下列包；
2. 备份您自己的配置文件；
3. 下载配置文件并粘贴覆盖文件；
4. （可选）利用karabiner修改caps键功能；
5. （可选）修改天气位置：`/Users/**USER_NAME**/.config/sketchybar/settings.sh`, 把`WEATHER_BAIDU_QUERY="上海闵行天气"`改为自己区域的位置名称。
6. （可选）本music脚本支持apple music、spotify和youtube music。默认开启spotify支持，apple music可修改在`~/.config/sketchybar/plugins/now_playing.sh`，将`get_spotify_info`行和下一行的`process_player_info`注释，并将`get_apple_music_info`和相应下一行的`process_player_info`取消注释。youtube music客户端用https://github.com/th-ch/youtube-music，并打开监听端口，将`/Users/wqin/.config/sketchybar/sketchybarrc`中`source "$ITEM_DIR/now_playing.sh"`改为`source "$ITEM_DIR/youtube-music.sh"`。
# homebrew
```
brew tap FelixKratz/formulae gromgit/fuse
brew install borders lua luajit starship neofetch neovim zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting

brew install --cask aerospace font-hack-nerd-font font-maple-mono font-sf-mono font-sf-pro sf-symbols font-sketchybar-app-font swipeaerospace wezterm

# karabiner
`karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/OthinusG/capslox-karabiner/refs/heads/main/capslox-karabiner.json`

#### Ref
https://github.com/QianSong1/wezterm-config?tab=readme-ov-file
https://www.youtube.com/watch?v=e34qllePuoc
https://github.com/patricorgi/dotfiles
https://github.com/clear668866x6/nvim?tab=readme-ov-file
https://github.com/manishprivet/.dotfiles/tree/main
https://github.com/sergii-dudar/dotfiles
