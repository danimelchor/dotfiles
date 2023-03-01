#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

disk=(
	label.font="$FONT:Heavy:12"
	label.color="$TEXT"
	icon="$DISK"
	icon.color="$MAROON"
	update_freq=300
	script="$PLUGIN_DIR/disk.sh"
	padding_left=10
)

sketchybar --add item disk right 		\
					 --set disk "${disk[@]}"
