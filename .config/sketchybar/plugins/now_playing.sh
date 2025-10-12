#!/usr/bin/env bash

# Focused to support players: MPD, Apple Music, Spotify (Disabled, need uncomment related functions).
# Apple Music & Spotify have basic support (without mouse control, volume scroll control, player volume level indication and change on play\pause statuse etc).
# MPD have full functionality (As it's my primary (platform independed) players between linux and macos)

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

CACHE_DIR="$HOME/dotfiles/temp"
CACHE_FILE="$CACHE_DIR/cache.now_playing.envs"

function build_mpd_player_name() {
    local vol=$(~/.cargo/bin/rmpc volume)
    PLAYER="MPD [ ${vol}%]"
}
function __write_tmp_envs_file() {
    mkdir -p "$CACHE_DIR"
    file_envs_content="PLAYER=\"$PLAYER\"\nTRACK=\"$TRACK\"\nARTIST=\"$ARTIST\""
    echo -e "$file_envs_content" > "${CACHE_FILE}"
}
function __read_tmp_envs_file() {
    if [ ! -f "$CACHE_FILE" ]; then
        return
    fi
    . "$CACHE_FILE"
}
function build_music_label() {
    echo "${TRACK} • ${ARTIST}"
}
if [ -f "$CACHE_FILE" ]; then
    # LAST_PLAYING_LABEL=$(bat -pp "$CACHE_FILE")
    __read_tmp_envs_file
    LAST_PLAYING_LABEL=$(build_music_label)
else
    LAST_PLAYING_LABEL="Paused"
fi

# Mouse control: supported only to MPD
if [[ "$SENDER" == "mouse."* ]] && [[ "$LAST_PLAYING_LABEL" == "MPD "* ]]; then
    # echo "sender: $SENDER, button: $BUTTON, modifier: $MODIFIER, scroll_delta: $SCROLL_DELTA" > /tmp/logs.txt
    case "$SENDER" in
        "mouse.clicked")
            case "$BUTTON" in
                "left")
                    if [ "$MODIFIER" = "ctrl" ]; then
                        ~/.cargo/bin/rmpc prev
                    else
                        ~/.cargo/bin/rmpc togglepause
                    fi
                    ;;
                "right")
                    if [ "$MODIFIER" = "ctrl" ]; then
                        ~/.cargo/bin/rmpc next
                    fi
                    ;;
            esac
            ;;
        "mouse.scrolled")
            if [ "$SCROLL_DELTA" -gt 0 ]; then
                ~/.cargo/bin/rmpc volume +5
            else
                ~/.cargo/bin/rmpc volume -5
            fi
            build_mpd_player_name
            __write_tmp_envs_file
            LAST_PLAYING_LABEL=$(build_music_label)
            # echo "$LAST_PLAYING_LABEL" > /tmp/logs.txt
            ;;
    esac
fi

# Function to get Spotify info
function get_spotify_info() {
    local state=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)
    PLAYER="Spotify"
    if [[ "$state" == "playing" ]]; then
        STATUS="playing"
        ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track as string' 2>/dev/null)
        TRACK=$(osascript -e 'tell application "Spotify" to name of current track as string' 2>/dev/null)
    elif [[ "$state" == "paused" ]]; then
        STATUS="paused"
    else
        STATUS="stopped"
    fi
}

# Function to get Apple Music info
function get_apple_music_info() {
    local state=$(osascript -e 'tell application "Music" to player state as string' 2>/dev/null)
    PLAYER="iTunes"
    if [[ "$state" == "playing" ]]; then
        STATUS="playing"
        ARTIST=$(osascript -e 'tell application "Music" to artist of current track as string' 2>/dev/null)
        TRACK=$(osascript -e 'tell application "Music" to name of current track as string' 2>/dev/null)
    elif [[ "$state" == "paused" ]]; then
        STATUS="paused"
    else
        STATUS="stopped"
    fi
}

# Function to get MPD info
function get_mpd_info() {
    local state=$(~/.cargo/bin/rmpc status | jq -r '.state')
    build_mpd_player_name
    if [[ "$state" == "Play" ]]; then
        STATUS="playing"
        local song_json=$(~/.cargo/bin/rmpc song)
        ARTIST=$(echo $song_json | jq -r '.metadata.artist')
        TRACK=$(echo $song_json | jq -r '.metadata.title')
    elif [[ "$state" == "Pause" ]]; then
        STATUS="paused"
    else
        STATUS="stopped"
    fi
}

function update_music_item() {
    # Update the Now Playing item (only if we're showing it)
    sketchybar --set "$NAME" \
        icon="$ICON" \
        icon.color="$ICON_COLOR" \
        label="$LABEL"
}

function process_player_info() {
    if [[ "$STATUS" == "playing" ]]; then
        sketchybar --set "$NAME" drawing=on
        full_lable=$(build_music_label)
        if [[ ${#full_lable} -gt 60 ]]; then
            LABEL="${full_lable:0:60}..."
        else
            LABEL="$full_lable"
        fi
        ICON_COLOR="$PLAYER_PLAY_ICON_COLOR"
        ICON="$PLAYER_PLAY"
        # echo -e "$full_lable" > "${CACHE_FILE}"
        __write_tmp_envs_file
        update_music_item
        exit 0
    fi
}

#get_apple_music_info
#process_player_info

#get_mpd_info
#process_player_info

# echo "STATUS: $STATUS" >/tmp/logs.txt
get_spotify_info
process_player_info

# in case no any player in status - playing
if [[ "$STATUS" == "paused" ]]; then
    sketchybar --set "$NAME" drawing=on
    ICON="$PLAYER_PAUSE"
    ICON_COLOR="$PLAYER_PAUSE_ICON_COLOR"
    LABEL=$LAST_PLAYING_LABEL
    update_music_item
else
    # No music playing - hide the item completely
    ICON_COLOR="$PLAYER_STOP_ICON_COLOR"
    ICON="$PLAYER_STOP"
    sketchybar --set "$NAME" drawing=off
fi