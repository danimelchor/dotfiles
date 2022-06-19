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
  rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  git clone -q --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  [ -d ~/.config/nvim.old ] && rm -rf ~/.config/nvim.old
  [ -d ~/.config/nvim ] && mv -f ~/.config/nvim ~/.config/nvim.old 
  [ -h ~/.config/nvim ] && rm ~/.config/nvim
  ln -s $INSTALL_DIR/nvim ~/.config/nvim
  mkdir -p ~/.config/nvim/undo
  echo "\033[1m\033[92mDone.\033[0m\n"
fi

# zshrc
prompt "Do you want to install my .zshrc?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v p10k)" ] && rm -rf ~/powerlevel10k && git clone -q --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

  [ -f ~/.zshrc.old ] && rm ~/.zshrc.old
  [ -f ~/.p10k.zsh.old ] && rm ~/.p10k.zsh.old

  [ -f ~/.p10k.zsh ] && mv -f ~/.p10k.zsh ~/.p10k.zsh.old 
  [ -f ~/.zshrc ] && mv -f ~/.zshrc ~/.zshrc.old

  [ -h ~/.zshrc ] && rm ~/.zshrc
  [ -h ~/.p10k.zsh ] && rm ~/.p10k.zsh

  ln -s $INSTALL_DIR/zshrc/.zshrc ~/.zshrc
  ln -s $INSTALL_DIR/zshrc/.p10k.zsh ~/.p10k.zsh
  echo "\033[1m\033[92mDone.\033[0m\n"
fi
