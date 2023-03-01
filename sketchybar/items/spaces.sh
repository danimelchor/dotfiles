#!/bin/sh

MAIN_DISPLAY_ICONS=("󰖟" "󰑴" "󰅩" "" "󰒱" "")
SECONDARY_DISPLAY_ICONS=("󰖟" "󰑴" "󰅩" "" "󰒱" "")
SPACE_ICONS=("${MAIN_DISPLAY_ICONS[@]}" "${SECONDARY_DISPLAY_ICONS[@]}")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)
sketchybar --add event refresh_focus  \
           --add event refresh_spaces
           

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              script="$PLUGIN_DIR/space.sh" \
                              label.drawing=off \
                              label.highlight=$RED                               \
                              label.align=center \
                              label.width=20 \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.width=30 \
                              width=40 \
                              align=center \
                              icon.align=center \
                              icon.y_offset=2 \
                              icon.font="Hack Nerd Font:Regular:16.0"         \
                              icon.color=$WHITE \
                              icon.background.height=2 \
                              icon.background.color=$MAIN_ACCENT \
                              icon.highlight_color=$MAIN_ACCENT \
                              icon.background.width=30 \
                              icon.background.y_offset=-13 \
                              background.color=$SURFACE0 \
                              background.corner_radius=0 \
            --subscribe space.$sid mouse.clicked refresh_spaces                             
done

# sketchybar   --add item       separator left                                  \
#              --set separator  icon=                                          \
#                               icon.font="Hack Nerd Font:Regular:16.0"         \
#                               padding_left=10                                 \
#                               padding_right=10                                \
#                               label.drawing=off                               \
#                               associated_display=active                       \
#                               icon.color=$WHITE


