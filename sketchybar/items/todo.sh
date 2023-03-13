#!/usr/bin/env bash

sketchybar --add item todo q                                                \
           --set todo update_freq=120                                            \
                       label.font="Hack Nerd Font:Regular:16.0"                     \
                       icon.font="$FONT:Bold:12"                                \
                       script="$PLUGIN_DIR/todo.sh"                             \
                       background.height=20                                         \
                       background.padding_right=6                                  \
                       padding_right=14 \
                       click_script="$PLUGIN_DIR/mark-todo.sh"
