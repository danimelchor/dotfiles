#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

sketchybar --add item  cpu right                                                   \
           --set cpu   update_freq=30                                              \
                       icon.font="Hack Nerd Font:Regular:12.0"         \
                       icon.padding_right=4                                        \
                       icon.color=$YELLOW                                       \
                       icon.y_offset=1                                             \
                       label.y_offset=1                                            \
                       label.font="$FONT:Bold:12"                                \
                       label.color=$YELLOW                                    \
                       label.padding_right=8                                       \
                       background.color=$YELLOW                                 \
                       background.height=2                                         \
                       background.y_offset=-9                                      \
                       background.padding_right=8                                  \
                       script="$PLUGIN_DIR/cpu.sh"                                 \
                       icon.padding_left=0 label.padding_right=2                   \
