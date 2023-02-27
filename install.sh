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

INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# nvim
prompt "Do you want to install my nvim config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v nvim)" ] && brew install nvim
  [ -f ~/.config/nvim ] && rm ~/.config/nvim
  ln -s $INSTALL_DIR/nvim ~/.config/nvim
  mkdir -p ~/.config/nvim/undo
  echo "\033[1m\033[92mDone.\033[0m\n"
fi

# kitty
prompt "Do you want to install my kitty config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v kitty)" ] && brew install kitty
  [ -f ~/.config/kitty ] && rm ~/.config/kitty
  ln -s $INSTALL_DIR/kitty ~/.config/kitty
  echo "\033[1m\033[92mDone.\033[0m\n"
fi

# zshrc
prompt "Do you want to install my zsh config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v p10k)" ] && rm -rf ~/powerlevel10k && git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  [ -f ~/.zshrc ] && rm ~/.zshrc
  [ -f ~/.p10k.zsh ] && rm ~/.p10k.zsh
  ln -s $INSTALL_DIR/.zshrc ~/.zshrc
  ln -s $INSTALL_DIR/.p10k.zsh ~/.p10k.zsh
  echo "\033[1m\033[92mDone.\033[0m\n"
fi

# tmux
prompt "Do you want to install my tmux config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v tmux)" ] && brew install tmux
  [ -f ~/.tmux.conf ] && rm ~/.tmux.conf
  ln -s $INSTALL_DIR/.tmux.conf ~/.tmux.conf
  echo "\033[1m\033[92mDone.\033[0m\n"
fi

# window manager
prompt "Do you want to install my window manager config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v skhd)" ] && brew install koekeishiya/formulae/skhd
  [ -f ~/.skhdrc ] && rm ~/.skhdrc
  ln -s $INSTALL_DIR/.skhdrc ~/.skhdrc

  ! [ -x "$(command -v yabai)" ] && brew install koekeishiya/formulae/yabai
  [ -f ~/.config/yabai ] && rm ~/.config/yabai
  ln -s $INSTALL_DIR/yabai ~/.config/yabai

  ! [ -x ~/Applications/Hammerspoon.app ] && brew install hammerspoon --cask
  [ -f ~/.hammerspoon ] && rm ~/.hammerspoon
  ln -s $INSTALL_DIR/.hammerspoon ~/.hammerspoon

  ln -s $INSTALL_DIR/simple-bar ~/Library/Application\ Support/Übersicht/widgets/

  brew services restart yabai
  brew services restart skhd

  echo "\033[1m\033[92mDone.\033[0m\n"
fi
