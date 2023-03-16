#!/usr/bin/env bash

ID=$(~/.cargo/bin/todo-rs ls --format json --filter today-and-past | jq -r '.[0].id')

if [ "$NAME" != "null" ]; then
  sketchybar -m --set todo label="󰄲"
  sleep 0.3
  ~/.local/bin/todo-rs complete --id $ID --complete complete
  ~/.config/sketchybar/plugins/todo.sh
fi

