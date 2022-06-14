prompt() {
  echo $1 
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) result=true; break;;
      No ) result=false; break;;
    esac
  done
}

INSTALL_DIR=$( dirname -- "$0"; )

# nvim
prompt "Do you want to install my nvim config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v nvim)" ] && brew install nvim
  rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  rm -rf ~/.config/nvim.old
  [ -d ~/.config/nvim ] && mv -f ~/.config/nvim ~/.config/nvim.old 
  ln -s $INSTALL_DIR/nvim ~/.config/nvim
  mkdir -p ~/.config/nvim/undo
fi

# zshrc
prompt "Do you want to install my .zshrc?"
if [ "$result" = true ]; then
  ln -s $INSTALL_DIR/.zshrc ~/.zshrc
fi
