# mac-dotfiles
## aerospace + sketchybar + borders + karabiner + wezterm + starship + nvim
这是我自用的 macOS dotfiles，主题风格灵感来源于 "MacOS"。
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert.png)
绝大部分配置都“借鉴”自社区里的大佬们，我只是根据自己的使用习惯进行了一些微调和整合。最终目标是打造一个简洁、高效且能让我专注于当前任务的桌面环境。为了实现高效的音乐控制，我对状态栏的音乐控件进行了自定义，操作逻辑如下：
| 操作          | 功能      |
| ------------- | --------- |
| 左键点击      | 播放/暂停 |
| 右键点击      | 下一曲    |
| Ctrl+右键点击 | 上一曲    |

**新特性**：点击当前app标签可弹出macos系统菜单栏
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert2.png)

**These are my personal macOS dotfiles, with a theme inspired by "MacOS".**
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert.png)
The vast majority of this configuration is borrowed from the work of others in the community; I've simply tweaked and integrated it to fit my own habits and workflow. The ultimate goal is to create a clean, efficient desktop environment that helps me stay focused on the task at hand.
For more efficient music control, I have customized the status bar music widget. The controls are as follows:

| Action             | Function       |
| ------------------ | -------------- |
| Left-click         | Play/Pause     |
| Right-click        | Next Track     |
| Ctrl + Right-click | Previous Track |


**New Feature**: The native macOS menu bar for the active application can now be accessed by clicking the current app label.
![image](https://github.com/OthinusG/mac-dotfiles/blob/main/readmefiles/insert2.png)

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
7. brew services start borders sketchybar
# 安装说明
1. 安装 Homebrew 和用 Brew 安装下列包；
2. 备份您自己的配置文件；
3. 下载配置文件并粘贴覆盖文件；
4. （可选）利用karabiner修改caps键功能；
5. （可选）修改天气位置：`/Users/**USER_NAME**/.config/sketchybar/settings.sh`, 把`WEATHER_BAIDU_QUERY="上海闵行天气"`改为自己区域的位置名称。
6. （可选）本music脚本支持apple music、spotify和youtube music。默认开启spotify支持，apple music可修改在`~/.config/sketchybar/plugins/now_playing.sh`，将`get_spotify_info`行和下一行的`process_player_info`注释，并将`get_apple_music_info`和相应下一行的`process_player_info`取消注释。youtube music客户端用https://github.com/th-ch/youtube-music，并打开监听端口，将`/Users/wqin/.config/sketchybar/sketchybarrc`中`source "$ITEM_DIR/now_playing.sh"`改为`source "$ITEM_DIR/youtube-music.sh"`。
7. brew services start borders sketchybar
# homebrew
```
brew tap FelixKratz/formulae gromgit/fuse deskflow/homebrew-tap
brew install borders mpfr brotli ncurses btop neovim c-ares node ca-certificates nowplaying-cli fastfetch ntfs-3g-mac fd openssl@3 fzf pandoc gcc pcre2 gettext pipx git python@3.13 glow readline gmp simdjson icu4c@77 sketchybar isl sqlite libidn2 starship libmpc tree-sitter libnghttp2 unibilium libnghttp3 utf8proc libngtcp2 uvwasi libunistring wget libuv xz llvm yyjson lpeg z3 lua zsh luajit zsh-autosuggestions luv zsh-completions lz4 zsh-syntax-highlighting mpdecimal zstd

brew install --casks nikitabobko/tap/aerospace mediosz/tap/swipeaerospace font-hack-nerd-font font-maple-mono font-sketchybar-app-font maccy mounty qlmarkdown sf-symbols wezterm input-source-pro sf-symbols
```
# karabiner
`karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/OthinusG/capslox-karabiner/refs/heads/main/capslox-karabiner.json`

#### Ref
https://github.com/QianSong1/wezterm-config?tab=readme-ov-file
https://www.youtube.com/watch?v=e34qllePuoc
https://github.com/patricorgi/dotfiles
https://github.com/clear668866x6/nvim?tab=readme-ov-file
https://github.com/manishprivet/.dotfiles/tree/main
https://github.com/sergii-dudar/dotfiles
https://github.com/Sinjhin/SketchyMenu/tree/main/sketchybar
