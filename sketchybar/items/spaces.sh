#!/bin/sh

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)
sketchybar --add event window_focus  \
           --add event windows_on_spaces
           

sid=0
spaces=()
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              icon=${SPACE_ICONS[i]}                        \
                              icon.padding_left=10                          \
                              icon.padding_right=10                         \
                              padding_left=2                                \
                              padding_right=2                               \
                              label.padding_right=20                        \
                              icon.highlight_color=$PEACH                   \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.background.height=26                    \
                              label.background.drawing=on                   \
                              label.background.color=$SURFACE2              \
                              label.background.corner_radius=100            \
                              label.drawing=off                             \
                              script="$PLUGIN_DIR/space.sh"                 \
                              background.color=$SURFACE1                    \
                              background.corner_radius=100                 \
                              background.height=26 \
            --subscribe space.$sid mouse.clicked                            \
                              window_focus                                  \
                              windows_on_spaces                             \
                              space_change
done

sketchybar --add bracket spaces '/space\..*/'                  \
           --set spaces  background.color=$SURFACE0        \
                         background.corner_radius=100      \
                         background.border_width=2

sketchybar   --add item       separator left                                  \
             --set separator  icon=                                          \
                              icon.font="Hack Nerd Font:Regular:16.0"         \
                              padding_left=10                                 \
                              padding_right=10                                \
                              label.drawing=off                               \
                              associated_display=active                       \
                              icon.color=$WHITE


