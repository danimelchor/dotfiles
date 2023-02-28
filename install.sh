prompt() {
  echo "\033[1m\033[93m$1 [Y/n] \033[0m\c"
  read yn
  if [ "$yn" = "" ]; then
    yn='Y'
  fi
  case $yn in
    [Yy]* ) result=true; break;;
    [Nn]* ) result=false; break;;
    * ) result=true; break;;
  esac
}

moveAndLink() {
  OLD=$2.old
  echo "Moving $2 to $OLD"
  [ -h $OLD ] && rm $OLD
  [ -d $OLD ] && rm -rf $OLD
  [ -f $OLD ] && rm -rf $OLD

  [ -h $2 ] && rm $2
  [ -d $2 ] && mv $2 $OLD
  [ -f $2 ] && mv $2 $OLD

  ln -s $1 $2
}

echoDone() {
  echo "\033[1m\033[92mDone.\033[0m\n"
}

INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# nvim
prompt "Do you want to install my nvim config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v nvim)" ] && brew install nvim
  moveAndLink $INSTALL_DIR/nvim ~/.config/nvim
  mkdir -p ~/.config/nvim/undo
  echoDone
fi

# kitty
prompt "Do you want to install my kitty config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v kitty)" ] && brew install kitty
  moveAndLink $INSTALL_DIR/kitty ~/.config/kitty
  echoDone
fi

# zshrc
prompt "Do you want to install my zsh config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v p10k)" ] && rm -rf ~/powerlevel10k && git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  moveAndLink $INSTALL_DIR/.zshrc ~/.zshrc
  moveAndLink $INSTALL_DIR/.p10k.zsh ~/.p10k.zsh
  echoDone
fi

# tmux
prompt "Do you want to install my tmux config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v tmux)" ] && brew install tmux
  moveAndLink $INSTALL_DIR/.tmux.conf ~/.tmux.conf
  echoDone
fi

# window manager
prompt "Do you want to install my window manager config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v skhd)" ] && brew install koekeishiya/formulae/skhd
  ! [ -x "$(command -v yabai)" ] && brew install koekeishiya/formulae/yabai
  ! [ -x "$(command -v sketchybar)" ] && brew install sketchybar
  ! [ -x /Applications/Hammerspoon.app ] && brew install hammerspoon --cask

  moveAndLink $INSTALL_DIR/.skhdrc ~/.config/.skhdrc
  moveAndLink $INSTALL_DIR/yabai ~/.config/yabai
  moveAndLink $INSTALL_DIR/sketchybar ~/.config/sketchybar
  moveAndLink $INSTALL_DIR/.hammerspoon ~/.hammerspoon
  moveAndLink $INSTALL_DIR/yabai/toggle-wm /usr/local/bin/toggle-wm

  brew services restart yabai
  brew services restart skhd
  brew services restart sketchybar

  echoDone
fi
