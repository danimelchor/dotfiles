#!/bin/sh

sketchybar --add       event        window_focus                  \
           --add       event        windows_on_spaces             \
           --add       item         current_app_icon left             \
           --set       current_app_icon script="$PLUGIN_DIR/current_app.sh" \
                                    label.font="sketchybar-app-font:Regular:16.0"   \
                                    associated_display=active     \
                                    icon.drawing=off              \
                                    label.color=$WHITE            \
                                    padding_left=10               \
                                    padding_right=0               \
           --subscribe current_app_icon window_focus              \
                                    windows_on_spaces             \
                                    mouse.clicked                 \
                                    front_app_switched            \
                                                                  \
           --add       item         current_app_name left         \
           --set       current_app_name    icon.drawing=off       \
                                    padding_right=10              \
                                    padding_left=0                \
                                    label.color=$WHITE            \
                                    label.font="$FONT:Black:12.0" \
                                    associated_display=active     \
                                                                  \
           --add bracket current_space current_app_name current_app_icon \
           --set current_space      background.color=$SURFACE0         \
                                    background.corner_radius=100

