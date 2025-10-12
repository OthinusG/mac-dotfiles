now_playing=(
    icon.padding_left=6
    icon.padding_right=5
    label.padding_left=0
    label.padding_right=6
    background.padding_right=2
    #background.padding_left=0
    update_freq=5
    label.font.style="Bold Italic"
    script="$PLUGIN_DIR/now_playing.sh"
    background.drawing=on
    background.color=0xffffffff
    label.color=0xff5699af
    drawing=off
    display=1
)

# Now Playing
sketchybar --add item now_playing left \
    --set now_playing "${now_playing[@]}" \
    --add event now_playing_update \
    --subscribe now_playing now_playing_update media_change mouse.clicked mouse.scrolled

# `now_playing_update` event triggering in karabiner elements config after changing MPD player controlling

# click_script="mpc toggle ; echo $SENDER > /tmp/logs.txt" \
    #click_script="mpc toggle" \
    # icon.font="SF Pro:Semibold:15.0" \
    # label.font="SF Pro:Medium:12.0" \
    # background.color=$BACKGROUND_1 \