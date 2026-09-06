#!/bin/bash

LIST_NAME="Inbox"

(
  LATEST_TASK=$(osascript -l JavaScript -e "
    var tasks = Application('Reminders').lists.byName('$LIST_NAME').reminders.whose({completed: false}).name();
    if (tasks.length > 0) {
      tasks.pop(); // 返回数组的最后一个元素
    } else {
      '';
    }
  " 2>/dev/null)

  if [[ -z "$LATEST_TASK" ]] || [[ "$LATEST_TASK" == "missing value" ]]; then
    sketchybar -m --set reminders width=0 \
                  --set reminders drawing=off
  else

    CLEAN_TASK=$(echo "$LATEST_TASK" | tr '\n' ' ' | tr '\r' ' ')
    MAX_LENGTH=25 
    
    if [ ${#CLEAN_TASK} -gt $MAX_LENGTH ]; then
        DISPLAY_TEXT="${CLEAN_TASK:0:$MAX_LENGTH}..."
    else
        DISPLAY_TEXT="$CLEAN_TASK"
    fi

    sketchybar -m --set reminders icon="􀁣" \
                  --set reminders label="$DISPLAY_TEXT" \
                  --set reminders width=dynamic \
                  --set reminders drawing=on
  fi

) </dev/null >/dev/null 2>&1 &
disown