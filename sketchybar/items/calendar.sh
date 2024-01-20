#!/bin/sh

sketchybar --add item calendar right                                                  \
           --set calendar update_freq=10                                               \
                       icon="󰥔"                                                   \
                       icon.font="Hack Nerd Font:Regular:12.0"                     \
                       icon.padding_right=4                                        \
                       icon.color=$BLUE                                       \
                       icon.y_offset=2                                             \
                       label.y_offset=2                                            \
                       label.font="$FONT:Bold:12"                                \
                       label.color=$BLUE                                      \
                       label.padding_right=8                                       \
                       background.color=$BLUE                                 \
                       background.height=2                                         \
                       background.padding_right=6                                  \
                       background.y_offset=-9                                      \
                       script="$PLUGIN_DIR/calendar.sh"                               \
                       icon.padding_left=0 label.padding_right=1
