prompt() {
  echo $1 
  select yn in "Yes" "No"; do
    case $yn in
      Yes ) result=true; break;;
      No ) result=false; break;;
    esac
  done
}

# nvim
prompt "Do you want to install nvim? [Y/n] "
if [ "$result" = true ]; then
  brew install nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  nvim_dir="$(pwd)/nvim"
  cd ~/.config
  [ -d "nvim" ] && mv ./nvim ./nvim.old 
  rm nvim
  ln -s $nvim_dir
fi
