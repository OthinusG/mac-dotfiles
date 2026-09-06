#!/bin/bash

LIST_NAME="Inbox"

if [ "$MODIFIER" = "ctrl" ] && [ "$BUTTON" = "left" ]; then
  osascript -e "tell application \"Reminders\" to set completed of (last item of (reminders of list \"$LIST_NAME\" whose completed is false)) to true" 2>/dev/null
  "$CONFIG_DIR/plugins/reminders.sh"

elif [ "$MODIFIER" = "ctrl" ] && [ "$BUTTON" = "right" ]; then
  open -a Reminders

fi