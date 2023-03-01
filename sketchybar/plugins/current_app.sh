#!/bin/sh

window_state() {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  APP_NAME=$(yabai -m query --windows --space | jq -r '.[] | select(.["has-focus"] == true) | .app')
  ICON="$($HOME/.config/sketchybar/plugins/icon_map.sh "$APP_NAME")"

  sketchybar -m --set current_app_icon label.color=$MAUVE label=$ICON label.drawing=on
  sketchybar -m --set current_app_name label=$APP_NAME label.drawing=on
}

windows_on_spaces () {
  CURRENT_SPACES="$(yabai -m query --displays | jq -r '.[].spaces | @sh')"

  args=()
  while read -r line
  do
    for space in $line
    do
      icon_strip=" "
      apps=$(yabai -m query --windows --space $space | jq -r ".[].app")
      if [ "$apps" != "" ]; then
        while IFS= read -r app; do
          icon_strip+=" $($HOME/.config/sketchybar/plugins/icon_map.sh "$app")"
        done <<< "$apps"
      fi
      args+=(--set space.$space label="$icon_strip" label.drawing=on)
    done
  done <<< "$CURRENT_SPACES"

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  yabai -m window --toggle zoom-fullscreen
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") exit 0
  ;;
  "window_focus") window_state 
  ;;
  "windows_on_spaces") windows_on_spaces
  ;;
esac
