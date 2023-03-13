#!/usr/bin/env bash

ID=$(~/.local/bin/rust-todo ls --format json --filter today-and-past | jq -r '.[0].id')

if [ "$NAME" != "null" ]; then
  sketchybar -m --set todo label="󰄲"
  sleep 0.3
  ~/.local/bin/rust-todo complete --id $ID --completed complete
  ~/.config/sketchybar/plugins/todo.sh
fi

