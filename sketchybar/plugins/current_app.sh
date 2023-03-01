#!/usr/bin/env bash

refresh_focus() {
  source "$HOME/.config/sketchybar/colors.sh"

  APP_NAME=$(yabai -m query --windows --space | jq -r '.[] | select(.["has-focus"] == true) | .app')
  ICON="$($HOME/.config/sketchybar/plugins/icon_map.sh "$APP_NAME")"

  if [ "$APP_NAME" = "" ]; then
    sketchybar -m --animate linear 20 --set current_app_icon drawing=off 
    sketchybar -m --animate linear 20 --set current_app_name drawing=off
  else
    sketchybar -m --animate linear 20 --set current_app_icon label.color=$MAUVE label=$ICON label.drawing=on drawing=on
    sketchybar -m --animate linear 20 --set current_app_name label=$APP_NAME label.drawing=on drawing=on
  fi
}


case "$SENDER" in
  "forced") exit 0
  ;;
  *) refresh_focus 
  ;;
esac
