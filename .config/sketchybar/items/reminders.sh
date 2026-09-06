sketchybar --add item reminders right \
           --set reminders update_freq=600 \
                         icon.font="SF Pro:Bold:16.0" \
                         icon.color=0xffeab308 \
                         icon.padding_right=5 \
                         icon.padding_left=0 \
                         label.font="SF Pro:Bold Italic:14.0" \
                         label.color=0xffffffff \
                         label.padding_right=0 \
					     label.color=$ACCENT_COLOR \
						 icon.color=$ACCENT_COLOR \
                         background.color=0x00ffffff \
                         background.height=25 \
						 icon.y_offset=1 \
						 label.y_offset=2 \
                         script="$PLUGIN_DIR/reminders.sh" \
                         click_script="$PLUGIN_DIR/reminders_click.sh" \
                         drawing=off