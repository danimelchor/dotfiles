#!/usr/bin/env bash

update() {
  WINDOWS=$(yabai -m query --windows --space $SID --display $DIS | jq length)
  WIDTH="dynamic"
  if [ "$WINDOWS" -eq 0 ]; then
    WIDTH=0
  fi

  sketchybar --set $NAME icon.highlight=$SELECTED label.width=$WIDTH
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
