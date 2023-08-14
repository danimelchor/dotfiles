#!/usr/bin/env bash

ID=$(~/.cargo/bin/todui ls --format json --date-filter today-and-past | jq -r '.[0].id')

if [ "$NAME" != "null" ]; then
  sketchybar -m --set todo label="󰄲"
  sleep 0.3
  ~/.cargo/bin/todui complete --id $ID --complete complete
  ~/.config/sketchybar/plugins/todo.sh
fi

