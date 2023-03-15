#!/usr/bin/env bash

source "$HOME/.config/sketchybar/icons.sh"
sketchybar --set brew label=$LOADING

brew upgrade
~/.config/sketchybar/plugins/brew.sh
