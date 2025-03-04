#!/usr/bin/env bash

getPercentage=$(TARGET_PATH="." top -l 1 | grep -E "^CPU" | grep -Eo '[^[:space:]]+%' | head -1 | sed 's/3\(.\)$/\1/' | cut -d "." -f1)

getMB=$(TARGET_PATH="." top -l1 | awk '/PhysMem/ {print $2}')

percentage=$(echo $getPercentage)
MB=$(echo $getMB)

sketchybar --set $NAME icon="" label="$MB ($percentage%)"
