if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh
#
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Fix path issues
PATH=/opt/homebrew/bin:$PATH
PATH="/usr/local/bin:$PATH"
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Disable weird cds
unsetopt autocd

alias proj="cd ~/Documents/CodeProjects"
alias c="clear"
alias e="exit"
alias v="nvim"
alias bu="cd ~/Documents/BU/Spring\ 2023"
alias survey="/Users/danielmelchor/Documents/CodeProjects/emmanuel/venv/bin/python3 /Users/danielmelchor/Documents/CodeProjects/emmanuel/survey.py;e"
alias pdf="/Users/danielmelchor/Documents/CodeProjects/pdf-summary/venv/bin/python3 /Users/danielmelchor/Documents/CodeProjects/pdf-summary/pdf"

# GIT ALIASES
alias gaa="git add ."
alias gcm="git cm"
alias gp="git push"
alias gs="git status"

# PYTHON ALIASES
alias ve="source venv/bin/activate"
alias dve="deactivate"
alias pipr="pip install -r requirements.txt"

# DOCKER COMPOSE ALIASES
alias dcu="docker-compose up -d;dclogs"
alias dclogs="docker-compose logs --follow"
alias dcr="docker-compose restart $1"
alias dcrb="docker-compose up --no-deps --detach --build $1;dclogs"
alias dcprune="docker system prune -a -f"

export EDITOR="nvim"
export ZLE_RPROMPT_INDENT=0

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/Documents/CodeProjects/dotfiles/zshrc/.p10k.zsh.
[[ ! -f ~/Documents/CodeProjects/dotfiles/zshrc/.p10k.zsh ]] || source ~/Documents/CodeProjects/dotfiles/zshrc/.p10k.zsh
