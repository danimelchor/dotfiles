# Check nvim is installed
if ! [ -x "$(command -v nvim)" ]; then
  brew install nvim
fi
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
brew install ctags

# Get dotfiles paths
nvim_dir="$(pwd)/nvim"

# Cd into dotfiles folder
cd ~/.config

# Make copies just in case
[ -d "nvim" ] && mv ./nvim ./nvim.old 
rm nvim

# Create symlinks
ln -s $nvim_dir
