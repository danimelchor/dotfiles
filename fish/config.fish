if test -e ~/stripe
    source ~/stripe/space-commander/bin/sc-env-activate.fish

    fish_add_path "$HOME/.rbenv/shims"
    fish_add_path "$HOME/.rbenv/bin"
    fish_add_path "$HOME/stripe/password-vault/bin"
    fish_add_path "$HOME/stripe/space-commander/bin"
    fish_add_path "$HOME/stripe/henson/bin"
    fish_add_path "$HOME/go/bin"

    abbr -a pipe 'cd ~/stripe/zoolander/src/python/pipeline/'
    abbr -a zoo 'cd ~/stripe/zoolander/'
    abbr -a viz 'cd ~/stripe/pay-server/viz/'
    abbr -a gocode 'cd ~/stripe/gocode/'
    abbr -a redshift 'cd ~/stripe/redshift/'
    abbr -a dot 'cd ~/Documents/dotfiles/'
    abbr -a personal 'cd ~/personal/'

    abbr -a qapay 'pay --host-type qa-mydata-standard'
    abbr -a pjk 'pay job:kill'
    abbr -a pjl 'pay job:logs'

    abbr -a mpt 'git switch master-passing-tests'
else
    abbr -a --set-cursor=% sv 'nvim scp://dmelchor@dmelchorpi.local/%'
end

functions -e fish_right_prompt

# If pyenv exists
if command -q pyenv
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path "$PYENV_ROOT/bin"
    pyenv init - fish | source
end

# If nodenv exists
if command -q nodenv
    nodenv init - | source
end

# PATH vars
fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/bin
fish_add_path "$HOME/.cargo/bin"
fish_add_path /usr/local/go/bin

# Utility aliases
abbr -a c clear
abbr -a e exit

# Eza
if command -q eza
    alias ls='eza'
end
abbr -a ll 'ls -l'
abbr -a lll 'ls -la'

# Neovim
function v
    # If no arg, open here
    if test -z $argv[1]
        nvim .
    # If the arg is a dir, cd and open
    else if test -d $argv[1]
        pushd $argv[1] || return 1
        nvim .
        popd
    # If the arg is a file, cd into base dir and open
    else
        pushd $(dirname $argv[1]) || return 1
        nvim $(basename $argv[1])
        popd
    end
end

# Git aliases
abbr -a gs 'git status'
abbr -a gp 'git push'
abbr -a gpv 'git push --no-verify'
abbr -a gp! 'git push --force-with-lease'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a grm 'git rm'
abbr -a gpu 'git push -u origin $(git rev-parse --abbrev-ref HEAD)'
abbr -a gpuv 'git push -u origin $(git rev-parse --abbrev-ref HEAD) --no-verify'
abbr -a gbd 'git branch -d'
abbr -a gbdf 'git branch -d (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gbDf 'git branch -D (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gbD 'git branch -D'
abbr -a gbda 'git branch --merged | egrep -v "(^\*|master|main|dev)'
abbr -a gswf 'git switch (git branch --sort=-committerdate | fzf | sed -e "s/[\*[:space:]]//g" | xargs)'
abbr -a gsw 'git switch'
abbr -a --set-cursor=% gswc 'git switch -c dmelchor/%'
abbr -a --set-cursor=% gcm 'git commit -m "%"'
abbr -a --set-cursor=% gcam 'git commit -am "%"'
abbr -a --set-cursor=% gac 'git add --all && git commit -m "%"'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'
abbr -a gl 'git pull'
abbr -a gr 'git rebase'
abbr -a grc 'git rebase --continue'
abbr -a gra 'git rebase --abort'
abbr -a gri 'git rebase -i'
abbr -a gf 'git fetch'
abbr -a gsur 'git submodule update --recursive'
abbr -a gfr 'git fetch origin master-passing-tests && git rebase origin/master-passing-tests'
abbr -a gfrm 'git fetch origin master && git rebase origin/master'

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

# Shell
set -gx SHELL /opt/homebrew/bin/fish

# Raspberry Pi
abbr -a pi 'ssh dmelchor@dmelchor.lan'

set -Ux STARSHIP_LOG 'error'
starship init fish | source

# === FISH GREETING ===
function fish_greeting
    todo
end

source ~/.config/fish/utils.fish
