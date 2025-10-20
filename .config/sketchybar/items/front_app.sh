#!/bin/bash

sketchybar --add item front_app left \
           --set front_app background.color="$ACCENT_COLOR" update_freq=6\
              icon.color="$BACKGROUND" \
              icon.font="sketchybar-app-font:Regular:13.0" \
              label.color="$BACKGROUND" \
              script="$PLUGIN_DIR/front_app.sh" \
              click_script="$PLUGIN_DIR/sketchymenu/app_menu.sh toggle" \
           --subscribe front_app front_app_switched mouse.exited.global
