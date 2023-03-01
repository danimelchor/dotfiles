#!/bin/sh

zen_on() {
  sketchybar --set '/cpu.*/' drawing=off \
             --set calendar icon.drawing=off \
             --set system.yabai drawing=off \
             --set separator drawing=off \
             --set front_app drawing=off \
             --set volume_alias drawing=off \
             --set brew drawing=off \
             --set battery drawing=off \
             --set '/space\..*/' drawing=off
}

zen_off() {
  sketchybar --set '/cpu.*/' drawing=on \
             --set calendar icon.drawing=on \
             --set separator drawing=on \
             --set front_app drawing=on \
             --set system.yabai drawing=on \
             --set volume_alias drawing=on \
             --set brew drawing=on \
             --set battery drawing=on \
             --set '/space\..*/' drawing=on
}

if [ "$1" = "on" ]; then
  zen_on
elif [ "$1" = "off" ]; then
  zen_off
else
  if [ "$(sketchybar --query calendar | jq -r ".icon.drawing")" = "on" ]; then
    zen_on
  else
    zen_off
  fi
fi

