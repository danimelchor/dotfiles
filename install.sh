#!/usr/bin/env bash

INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
BACKUP_DIR="$HOME/.dotfiles-backup"

rm -rf $BACKUP_DIR
mkdir $BACKUP_DIR

# Dict relative_name -> destination
declare -A files
files["fish"]="$HOME/.config"
files["kitty"]="$HOME/.config"
files["alacritty"]="$HOME/.config"
files["neofetch"]="$HOME/.config"
files["nvim"]="$HOME/.config"
files["codespell"]="$HOME/.config"
files["sketchybar"]="$HOME/.config"
files["yabai"]="$HOME/.config"
files[".tmux.conf"]="$HOME"
files[".skhdrc"]="$HOME"
files[".ideavimrc"]="$HOME"
files["starship.toml"]="$HOME/.config"
files["ghostty"]="$HOME/.config"

# Backup existing files
echo -e "\033[1m\033[92mBacking up existing files...\033[0m"

for file in "${!files[@]}"; do
    if [ -h "${files[$file]}/$file" ]; then
        echo "Removing symlink ${files[$file]}/$file"
        rm "${files[$file]}/$file"
    elif [ -e "${files[$file]}" ]; then
        echo "Backing up ${files[$file]}/$file to $BACKUP_DIR"
        mv "${files[$file]}/$file" "$BACKUP_DIR"
    fi
done

echo -e "\n\033[1m\033[92mCopying new files...\033[0m"

# Copy new files
for file in "${!files[@]}"; do
    echo "Symlinking $file to ${files[$file]}"
    ln -s "$INSTALL_DIR/$file" "${files[$file]}"
done

# For each script, symlink to ~/.local/bin
echo -e "\n\033[1m\033[92mCopying scripts...\033[0m"
for script in $INSTALL_DIR/scripts/*; do
    script=$(basename "$script")
    if [ -h $HOME/.local/bin/$script ]; then
        echo "Removing symlink $HOME/.local/bin/$script"
        rm $HOME/.local/bin/$script
    fi
    echo "Symlinking $script to ~/.local/bin"
    ln -s $INSTALL_DIR/scripts/$script $HOME/.local/bin/
    chmod +x $HOME/.local/bin/$script
done

echo -e "\n\033[1m\033[92mDone!\033[0m\n"
