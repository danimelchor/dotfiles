#!/bin/sh

# Spaces
MAIN_DISPLAY_ICONS=("󰖟" "󰅩" "" "󰒱" "" "󰕧")
SECONDARY_DISPLAY_ICONS=("󰖟" "󰅩" "" "󰒱" "" "󰕧")
SPACE_ICONS=("${MAIN_DISPLAY_ICONS[@]}" "${SECONDARY_DISPLAY_ICONS[@]}")

# Colors
COLORS=("$BLUE" "$RED" "$PEACH" "$YELLOW" "$GREEN" "$MAUVE") 
COLORS=("${COLORS[@]}" "${COLORS[@]}")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)
sketchybar --add event refresh_spaces
           

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  COLOR=${COLORS[i]}
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              script="$PLUGIN_DIR/space.sh" \
                              label.drawing=off \
                              label.align=center \
                              label.width=20 \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.width=30 \
                              width=40 \
                              align=center \
                              icon.align=center \
                              icon.y_offset=2 \
                              icon.font="Hack Nerd Font:Regular:18.0"         \
                              icon.color=$COLOR \
                              icon.background.height=2 \
                              icon.background.color=$COLOR  \
                              icon.highlight_color=$COLOR \
                              icon.background.width=30 \
                              icon.background.y_offset=-16 \
                              background.color=$SURFACE0 \
                              background.corner_radius=0 \
            --subscribe space.$sid mouse.clicked refresh_spaces                             
done

