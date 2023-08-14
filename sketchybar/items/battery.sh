#!/usr/bin/env bash

sketchybar --add item battery right                                                \
           --set battery update_freq=120                                             \
                       icon.font="Hack Nerd Font:Regular:12.0"                     \
                       icon.padding_right=3                                        \
                       icon.color=$GREEN                                       \
                       icon.y_offset=2                                             \
                       label.y_offset=1                                            \
                       label.font="$FONT:Bold:12"                                \
                       label.color=$GREEN                                      \
                       label.padding_right=8                                       \
                       background.color=$GREEN                                 \
                       background.height=2                                         \
                       background.y_offset=-9                                      \
                       background.padding_right=8                                  \
                       script="$PLUGIN_DIR/battery.sh"                             \
                       icon.padding_left=0 label.padding_right=0
