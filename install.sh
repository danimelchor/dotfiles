INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

cp -fr $INSTALL_DIR/nvim ~/.config/
cp -fr $INSTALL_DIR/kitty ~/.config/
cp -fr $INSTALL_DIR/.zshrc ~
cp -fr $INSTALL_DIR/.p10k.zsh ~
cp -fr $INSTALL_DIR/.tmux.conf ~
cp -fr $INSTALL_DIR/.skhdrc ~
cp -fr $INSTALL_DIR/yabai ~/.config
cp -fr $INSTALL_DIR/sketchybar ~/.config
cp -fr $INSTALL_DIR/.hammerspoon ~

# Install all scripts and chmod +x them
cp -fr $INSTALL_DIR/scripts/* ~/.local/bin
chmod +x ~/.local/bin/*

echo "\033[1m\033[92mDone.\033[0m\n"
