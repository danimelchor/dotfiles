#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

PREV=$(sketchybar --query brew | jq -r .text.label)
sketchybar --set brew label=$LOADING

BREW=$(brew outdated | wc -l | xargs)
if [ "$BREW" -eq "0" ]; then
  BREW="0"
else
  BREW="$BREW"
fi

sketchybar --set brew label="$BREW" 

if [ "$BREW" != "$PREV" ]; then
  sketchybar --animate tanh 15 --set brew label.y_offset=5 label.y_offset=1
fi
