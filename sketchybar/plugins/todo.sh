#!/bin/bash

PAST=$(~/.cargo/bin/todo-rs ls --format json --date-filter past | jq -r '.[0].name')
TODAY=$(~/.cargo/bin/todo-rs ls --format json --date-filter today | jq -r '.[0].name')
LENGTH=$(~/.cargo/bin/todo-rs ls --format json --date-filter today | jq length)

if [ "$PAST" = "null" ] && [ "$TODAY" = "null" ]; then
  LABEL="No tasks for today"
  ICON="󰄲"
  COLOR=0xffffffff
elif [ "$PAST" != "null" ]; then
  LABEL=$PAST
  ICON="󰄱"
  COLOR=0xfff38ba8
elif [ "$TODAY" != "null" ]; then
  LABEL="$TODAY"
  ICON="󰄱"
  COLOR=0xffffffff
else
  LABEL="All for today"
  ICON="󰄲"
  COLOR=0xffffffff
fi

if [ "$LENGTH" -gt 1 ]; then
  LABEL="$LABEL (+$((LENGTH-1)))"
fi

# Switched them around because I want the icon to be on the right
sketchybar -m --set todo             \
  label="$ICON"                          \
  icon="$LABEL"                  \
  label.color="$COLOR"            \
  icon.color="$COLOR"             
