prompt() {
  echo $1 
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) result=true; break;;
      No ) result=false; break;;
    esac
  done
}

INSTALL_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Install dir: $INSTALL_DIR"

# nvim
prompt "Do you want to install my nvim config?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v nvim)" ] && brew install nvim
  rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  [ -d ~./config/nvim.old ] && rm -rf ~/.config/nvim.old
  [ -d ~/.config/nvim ] && mv -f ~/.config/nvim ~/.config/nvim.old 
  cp -R $INSTALL_DIR/nvim ~/.config/nvim
  mkdir -p ~/.config/nvim/undo
fi

# zshrc
prompt "Do you want to install my .zshrc?"
if [ "$result" = true ]; then
  ! [ -x "$(command -v p10k)" ] && rm -rf ~/powerlevel10k && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  [ -f ~/.zshrc.old ] && rm ~/.zshrc
  [ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.old
  cp $INSTALL_DIR/zshrc/.zshrc ~/.zshrc
  cp $INSTALL_DIR/zshrc/.p10k.zsh ~/.p10k.zsh
fi
