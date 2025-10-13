#!/usr/bin/env bash

# Fast SketchyBar App Menu with Submenu Support
# Loads submenus on-demand for speed

# 处理全局鼠标退出事件以自动关闭菜单
if [ "$SENDER" = "mouse.exited.global" ]; then
    # 只有当菜单真正打开时才关闭它
    CURRENT_STATE=$(sketchybar --query front_app 2>/dev/null | jq -r '.popup.drawing')
    if [ "$CURRENT_STATE" = "on" ]; then
        #echo "[DEBUG] Global mouse exit detected and menu is open, closing menu" >> /tmp/sketchybar_debug.log
        sketchybar --set front_app popup.drawing=off
        clear_menu
    fi
    exit 0
fi

# Handle different commands
CMD="${1:-toggle}"
MENU_PATH="${2:-}"

# Get plugin directory
PLUGIN_DIR="${PLUGIN_DIR:-$HOME/.config/sketchybar/plugins}"

# 添加详细的调试日志
mkdir -p /tmp  # 确保目录存在
#echo "[DEBUG] App menu script started with CMD: $CMD, MENU_PATH: $MENU_PATH" >> /tmp/sketchybar_debug.log
#echo "[DEBUG] PLUGIN_DIR: $PLUGIN_DIR" >> /tmp/sketchybar_debug.log
#echo "[DEBUG] Script path: $0" >> /tmp/sketchybar_debug.log

export PATH="/usr/local/bin:$PATH"  # 确保 jq 等命令在路径中

clear_menu() {
    #echo "[DEBUG] Clearing menu items..." >> /tmp/sketchybar_debug.log
    sketchybar --query front_app 2>/dev/null | jq -r '.popup.items[]?' | while read -r item;
    do
       # echo "[DEBUG] Removing item: $item" >> /tmp/sketchybar_debug.log
        [ -n "$item" ] && sketchybar --remove "$item" 2>/dev/null || true
    done
}

case "$CMD" in
    toggle)    
        #echo "[DEBUG] Toggle command executed" >> /tmp/sketchybar_debug.log
        # Check state FIRST
        STATE=$(sketchybar --query front_app 2>/dev/null | jq -r '.popup.drawing')
        #echo "[DEBUG] Current popup state: $STATE" >> /tmp/sketchybar_debug.log
    
        if [ "$STATE" = "on" ]; then
            # Close menu
            #echo "[DEBUG] Closing menu" >> /tmp/sketchybar_debug.log
            sketchybar --set front_app popup.drawing=off
            # Cleanup
            clear_menu
        else
            # Open menu and show top level
            #echo "[DEBUG] Opening menu and loading top level" >> /tmp/sketchybar_debug.log
            # 先清理之前可能残留的菜单项
            clear_menu
            # 然后再打开菜单
            sketchybar --set front_app popup.drawing=on
            # 添加一个小延迟确保菜单已完全显示
            sleep 0.05
            # 加载顶级菜单项
            "$0" load_top
        fi
        ;;
        
    load_top)
        #echo "[DEBUG] Load top command executed" >> /tmp/sketchybar_debug.log
        # Clear existing items
        clear_menu
        
        # Get current app
        APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true')
        #echo "[DEBUG] Current app: $APP" >> /tmp/sketchybar_debug.log
        
        # 添加更多的调试信息，确保后续代码执行
        #echo "[DEBUG] About to get menu bar items..." >> /tmp/sketchybar_debug.log
        
        # Get menu bar items
        MENUS=$(osascript << EOF

tell application "System Events"
    tell process "$APP"
        set menuList to {}
        set idx to 0
        repeat with mb in menu bar items of menu bar 1
            try
                set menuName to name of mb
                set hasSubmenu to false
                try
                    set m to menu 1 of mb
                    set hasSubmenu to true
                end try
                if hasSubmenu then
                    set end of menuList to menuName & "|" & idx & "|Y"
                else
                    set end of menuList to menuName & "|" & idx & "|N"
                end if
            end try
            set idx to idx + 1
        end repeat
        return menuList
    end tell
end tell
EOF
        )
        
        # Parse and add menu items
        i=0
        echo "$MENUS" | tr ',' '\n' | while read -r line;
        do
            # Parse: name|index|hasSubmenu
            IFS='|' read -r name idx has_sub <<< "$(echo "$line" | tr -d ' "')"
            
            if [ -n "$name" ] && [ "$name" != "missing" ]; then
                if [ "$has_sub" = "Y" ]; then
                    # Has submenu - add arrow
                    sketchybar --add item "menu.item.$i" popup.front_app \
                        --set "menu.item.$i" \
                            label="$name ▸" \
                            icon.drawing=off \
                            click_script="$PLUGIN_DIR/sketchymenu/app_menu.sh load_sub '$idx'"
                else
                    # No submenu
                    sketchybar --add item "menu.item.$i" popup.front_app \
                        --set "menu.item.$i" \
                            label="$name" \
                            icon.drawing=off \
                            click_script="echo 'Execute: $name'"
                fi
                i=$((i + 1))
            fi
        done
        ;;
        
    load_sub)
        # Load submenu items
        if [ -z "$MENU_PATH" ]; then exit 0; fi
        
        # Clear existing items
        clear_menu
        
        # Add back button
        sketchybar --add item "menu.item.back" popup.front_app \
            --set "menu.item.back" \
                label="‹ Back" \
                icon.drawing=off \
                click_script="$PLUGIN_DIR/sketchymenu/app_menu.sh load_top"
        
        # Add separator
        sketchybar --add item "menu.item.sep" popup.front_app \
            --set "menu.item.sep" \
                label="────────" \
                icon.drawing=off
        
        # Get submenu items for the selected menu
        APP=$(osascript -e 'tell application "System Events" to name of first application process whose frontmost is true')
        MENU_INDEX=$((MENU_PATH + 1))
        
        ITEMS=$(osascript << EOF
tell application "System Events"
    tell process "$APP"
        try
            set menuBarItem to menu bar item $MENU_INDEX of menu bar 1
            set menuItems to menu items of menu 1 of menuBarItem
            set itemList to {}
            repeat with mi in menuItems
                try
                    set itemName to name of mi
                    set itemEnabled to enabled of mi
                    if itemName is missing value then
                        set end of itemList to "---"
                    else if itemEnabled then
                        set end of itemList to itemName
                    else
                        set end of itemList to "[" & itemName & "]"
                    end if
                end try
            end repeat
            return itemList
        on error
            return {}
        end try
    end tell
end tell
EOF
        )
        
        # Add submenu items
        i=2
        echo "$ITEMS" | tr ',' '\n' | while read -r item;
        do
            item=$(echo "$item" | tr -d '"' | xargs)
            
            if [ "$item" = "---" ]; then
                # Separator
                sketchybar --add item "menu.sub.$i" popup.front_app \
                    --set "menu.sub.$i" \
                        label="────────" \
                        icon.drawing=off
            elif [ -n "$item" ]; then
                # Check if disabled (wrapped in brackets)
                if [[ "$item" == \[*\] ]]; then
                    # Disabled item
                    item=${item:1:-1}
                    sketchybar --add item "menu.sub.$i" popup.front_app \
                        --set "menu.sub.$i" \
                            label="$item" \
                            label.color=0xff888888 \
                            icon.drawing=off
                else
                    # Enabled item
                    sketchybar --add item "menu.sub.$i" popup.front_app \
                        --set "menu.sub.$i" \
                            label="$item" \
                            icon.drawing=off \
                            click_script="$PLUGIN_DIR/sketchymenu/click_menu_item.applescript '$APP' '$MENU_PATH/$((i-2))' && sketchybar --set front_app popup.drawing=off"
                fi
            fi
            i=$((i + 1))
            if [ $i -gt 30 ]; then break; fi
        done
        ;;
esac