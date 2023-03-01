#!/usr/bin/env bash

update() {
  args=()
  if [ "$SELECTED" = "true" ]; then
    args+=(--set $NAME icon.background.y_offset=-13)
 else
    args+=(--set $NAME icon.background.y_offset=-20)
 fi
  
  args+=(--set $NAME icon.highlight=$SELECTED background.drawing=$SELECTED)

  sketchybar -m --animate tanh 10 "${args[@]}"
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
