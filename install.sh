prompt() {
  read -p $1 -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    result = true
  else
    retult = false
  fi
}

# nvim
prompt("Do you want to install nvim? [Y/n] ")
if [[ result ]] then
  brew install nvim
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  nvim_dir="$(pwd)/nvim"
  [ -d "nvim" ] && mv ./nvim ./nvim.old 
  rm nvim
  ln -s $nvim_dird ~/.config
fi
