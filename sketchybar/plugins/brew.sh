#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"
source "$HOME/.config/sketchybar/colors.sh"

PREV=$(sketchybar --query packages | jq -r .text.label)
sketchybar --set $NAME label=$LOADING

brewLIST=$(brew outdated)
BREW=$(echo "$brewLIST" | wc -l)
MAS='0'
DEFAULT="0"

# sum of all outdated packages
SUM=$(( ${BREW:-DEFAULT} + ${MAS:-DEFAULT} ))

if [[ $SUM -gt 0 ]]; then
  FINAL="$SUM"
else
  FINAL=0
fi

sketchybar --set $NAME label="$FINAL" 

if [ "$FINAL" != "$PREV" ]; then
  sketchybar --animate tanh 15 --set $NAME label.y_offset=5 label.y_offset=1
fi
