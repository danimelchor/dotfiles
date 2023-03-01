#!/usr/bin/env bash

source "$HOME/.config/sketchybar/colors.sh"

cpu_percent=(
	label.font="$FONT:Heavy:12"
	label=-%
	label.color="$TEXT"
	icon="$CPU"
	icon.color="$BLUE"
	update_freq=30
	mach_helper="$HELPER"
)

sketchybar 	--add item cpu.percent right --set cpu.percent "${cpu_percent[@]}"
