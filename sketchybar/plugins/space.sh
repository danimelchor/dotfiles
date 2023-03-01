#!/usr/bin/env bash

update() {
  WINDOWS=$(yabai -m query --windows --space $SID --display $DIS | jq length)
  WIDTH="dynamic"
  if [ "$WINDOWS" = 0 ]; then
    WIDTH=0
  fi

  source "$HOME/.config/sketchybar/colors.sh"
  COLOR=$WHITE
  if [ "$SELECTED" = "true" ]; then
    COLOR=$MAIN_ACCENT
  fi

  sketchybar --set $NAME icon.color=$COLOR label.width=$WIDTH
}

mouse_clicked() {
  yabai -m space --focus $SID 2>/dev/null
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
