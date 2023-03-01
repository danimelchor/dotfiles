#!/usr/bin/env bash

sketchybar --add item  os right                                                   \
           --set os   update_freq=6400                                            \
                       icon.font="Hack Nerd Font:Regular:12.0"         \
                       icon.padding_right=4                                        \
                       icon.color=$FLAMINGO                                       \
                       icon.y_offset=1                                             \
                       label.y_offset=1                                            \
                       label.font="$FONT:Bold:12"                                \
                       label.color=$FLAMINGO                                      \
                       label.padding_right=8                                       \
                       background.color=$FLAMINGO                                 \
                       background.height=2                                         \
                       background.y_offset=-9                                      \
                       background.padding_right=8                                  \
                       script="$PLUGIN_DIR/os.sh"                              \
                       icon.padding_left=-1 label.padding_right=2
