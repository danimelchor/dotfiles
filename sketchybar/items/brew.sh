#!/usr/bin/env bash

sketchybar --add item brew right                                                \
           --set brew update_freq=1800                                          \
                       icon="󰏔"                                                   \
                       icon.font="Hack Nerd Font:Regular:12.0"         \
                       icon.padding_right=2                                        \
                       icon.color=$PEACH                                       \
                       icon.y_offset=1                                             \
                       label.y_offset=1                                            \
                       label.font="$FONT:Bold:12"                                \
                       label.color=$PEACH                                      \
                       label.padding_right=8                                       \
                       background.color=$PEACH                                 \
                       background.height=2                                         \
                       background.y_offset=-9                                      \
                       background.padding_right=8                                  \
                       script="$PLUGIN_DIR/brew.sh"                     \
                       icon.padding_left=0 label.padding_right=2 \
                       click_script="$PLUGIN_DIR/install-brew.sh"
