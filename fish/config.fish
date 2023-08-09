# STRIPE CONFIG
source (rbenv init -|psub)
source ~/stripe/space-commander/bin/sc-env-activate.fish
functions -e fish_right_prompt

set -Ux PYENV_ROOT $HOME/.pyenv
pyenv init - | source

fish_add_path "$PYENV_ROOT/bin"
fish_add_path "$HOME/.rbenv/shims"
fish_add_path "$HOME/.rbenv/bin"
fish_add_path "$HOME/stripe/password-vault/bin"
fish_add_path "$HOME/stripe/space-commander/bin"
fish_add_path "$HOME/stripe/henson/bin"
fish_add_path /opt/homebrew/bin
# END STRIPE CONFIG

fish_add_path ~/.local/bin
fish_add_path /usr/local/bin
fish_add_path "$HOME/.cargo/bin"

abbr -a c clear
abbr -a e exit
abbr -a zoo 'cd ~/stripe/zoolander/'
abbr -a dot 'cd ~/Documents/dotfiles/'
abbr -a personal 'cd ~/personal/'
abbr -a pipe 'cd ~/stripe/zoolander/src/python/pipeline/'

if command -v exa > /dev/null
	abbr -a l 'exa'
	abbr -a ls 'exa'
	abbr -a ll 'exa -l'
	abbr -a lll 'exa -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

function v
    if test -z $argv[1]
        nvim .
    else
        nvim $argv[1]
    end
end


# Git aliases
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gp! 'git push --force-with-lease'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a grm 'git rm'
abbr -a gpu 'git push -u origin $(git rev-parse --abbrev-ref HEAD)'
abbr -a gbd 'git branch -d'
abbr -a gbdf 'git branch -d (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gbDf 'git branch -D (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gbD 'git branch -D'
abbr -a gbda 'git branch --merged | egrep -v "(^\*|master|main|dev)'
abbr -a gswf 'git switch (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gsw 'git switch'
abbr -a gswc 'git switch -c'
abbr -a --set-cursor=% gcm 'git commit -m "%"'
abbr -a --set-cursor=% gcam 'git commit -am "%"'
abbr -a --set-cursor=% gac 'git add --all && git commit -m "%"'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gl 'git pull'
abbr -a grb 'git rebase'
abbr -a grbc 'git rebase --continue'
abbr -a grba 'git rebase --abort'
abbr -a grbi 'git rebase -i'
abbr -a gf 'git fetch'
abbr -a gsur 'git submodule update --recursive'

# Tmux aliases
abbr -a t 'tmux'
abbr -a ta 'tmux attach'
abbr -a tks 'tmux kill-session'
abbr -a tksa 'tmux kill-session -a'
abbr -a tmls 'tmux ls'

# Python aliases
abbr -a ve "source venv/bin/activate.fish"
abbr -a dve "deactivate"
abbr -a pipr "pip install -r requirements.txt"

# tmux sessionizer
bind \cf tmux-sessionizer
setenv FZF_DEFAULT_OPTS "--border --color 'pointer:#B3E1A7,bg+:-1,fg+:#B3E1A7'"

# Editor
set -x EDITOR nvim
set -x GIT_EDITOR $EDITOR

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

set -Ux STARSHIP_LOG 'error'
starship init fish | source

function fish_greeting
    echo
    neofetch
end

source ~/.config/fish/autogen.fish
