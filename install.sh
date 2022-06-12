# Get dotfiles paths
nvim_dir="$(pwd)/nvim"

# Cd into dotfiles folder
cd ~/.config

# Make copies just in case
[ -d "nvim" ] && mv ./nvim ./nvim.old 

# Create symlinks
ln -s $nvim_dir
