if test -e ~/stripe
    source ~/stripe/space-commander/bin/sc-env-activate.fish
    bass source /etc/profile

    fish_add_path "$PYENV_ROOT/bin"
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

    abbr -a cimypy 'bazel build //tools/build_rules/linting/private/py_tools:mypy && ~/stripe/zoolander/bazel-bin/tools/build_rules/linting/private/py_tools/mypy'

    abbr -a qapay 'pay --host-type qa-mydata-standard'
    abbr -a pjk 'pay job:kill'
    abbr -a pjl 'pay job:list'
    abbr -a pu '~/payup.sh'

    abbr -a iceberg 'pay job:run bazel run src/scala/com/stripe/iceberg/cli --'
    abbr -a mpt 'git switch master-passing-tests'

    # Postgres
    set -Ux PGDATA '/usr/local/var/postgres'

    set -x PIPELINE_MODE dev
    set -gx PYENV_VERSION 3.8.17

    set -gx PAY_SKIP_REACHABILITY_CHECKS true
else
    abbr -a --set-cursor=% sv 'nvim scp://dmelchor@dmelchorpi.local/%'
    set -gx LIBTORCH $(brew --cellar pytorch)/$(brew info --json pytorch | jq -r '.[0].installed[0].version')
    set -gx LD_LIBRARY_PATH $LIBTORCH/lib
end

functions -e fish_right_prompt

# If pyenv exists
if command -v pyenv > /dev/null
    set -Ux PYENV_ROOT $HOME/.pyenv
    pyenv init - | source
end

# If nodenv exists
if command -v nodenv > /dev/null
    nodenv init - | source
end

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/bin
fish_add_path "$HOME/.cargo/bin"
fish_add_path /usr/local/go/bin

abbr -a c clear
abbr -a e exit

if command -v eza > /dev/null
    abbr -a l 'eza'
    abbr -a ls 'eza'
    abbr -a ll 'eza -l'
    abbr -a lll 'eza -la'
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

if command -v zoxide > /dev/null
    zoxide init fish | source
    alias cd='z'
end

# Git aliases
abbr -a gs 'git status'
abbr -a gp 'git push --no-verify'
abbr -a gpv 'git push'
abbr -a gp! 'git push --force-with-lease'
abbr -a ga 'git add'
abbr -a gaa 'git add --all'
abbr -a grm 'git rm'
abbr -a gpu 'git push -u origin $(git rev-parse --abbrev-ref HEAD) --no-verify'
abbr -a gpuv 'git push -u origin $(git rev-parse --abbrev-ref HEAD)'
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

# Todui
abbr -a td 'nvim ~/todo.md'

# Raspberry Pi
abbr -a pi 'ssh dmelchor@dmelchor.lan'

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

# === FISH GREETING ===
function fish_greeting
    echo
    neofetch
    show-todos
end

source ~/.config/fish/utils.fish
