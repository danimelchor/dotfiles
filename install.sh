#!/usr/bin/env bash

INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BACKUP_DIR="$HOME/.dotfiles-backup"

mkdir -p $BACKUP_DIR

# Dict relative_name -> destination
declare -A files
files["nvim"]="$HOME/.config/nvim"
files["kitty"]="$HOME/.config/kitty"
files[".zshrc"]="$HOME/.zshrc"
files[".p10k.zsh"]="$HOME/.p10k.zsh"
files[".tmux.conf"]="$HOME/.tmux.conf"
files[".skhdrc"]="$HOME/.skhdrc"
files["yabai"]="$HOME/.config/yabai"
files["sketchybar"]="$HOME/.config/sketchybar"
files[".hammerspoon"]="$HOME/.hammerspoon"

# cp -fr $INSTALL_DIR/nvim ~/.config/
# cp -fr $INSTALL_DIR/kitty ~/.config/
# cp -fr $INSTALL_DIR/.zshrc ~
# cp -fr $INSTALL_DIR/.p10k.zsh ~
# cp -fr $INSTALL_DIR/.tmux.conf ~
# cp -fr $INSTALL_DIR/.skhdrc ~
# cp -fr $INSTALL_DIR/yabai ~/.config
# cp -fr $INSTALL_DIR/sketchybar ~/.config
# cp -fr $INSTALL_DIR/.hammerspoon ~

# Backup existing files
echo -e "\033[1m\033[92mBacking up existing files...\033[0m"

for file in "${!files[@]}"; do
    if [ -e "${files[$file]}" ]; then
        echo "Backing up ${files[$file]} to $BACKUP_DIR"
        cp -fr "${files[$file]}" "$BACKUP_DIR"
    fi
done

echo -e "\n\033[1m\033[92mCopying new files...\033[0m"

# Copy new files
for file in "${!files[@]}"; do
    echo "Copying $file to ${files[$file]}"
    cp -fr "$INSTALL_DIR/$file" "${files[$file]}"
done

# Install all scripts and chmod +x them
cp -fr $INSTALL_DIR/scripts/* ~/.local/bin
chmod +x ~/.local/bin/*

echo -e "\n\033[1m\033[92mDone!\033[0m\n"
