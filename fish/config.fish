if test -e ~/stripe
    source (rbenv init -|psub)
    source (nodenv init - | psub)
    source ~/stripe/space-commander/bin/sc-env-activate.fish

    fish_add_path "$PYENV_ROOT/bin"
    fish_add_path "$HOME/.rbenv/shims"
    fish_add_path "$HOME/.rbenv/bin"
    fish_add_path "$HOME/stripe/password-vault/bin"
    fish_add_path "$HOME/stripe/space-commander/bin"
    fish_add_path "$HOME/stripe/henson/bin"

    abbr -a pipe 'cd ~/stripe/zoolander/src/python/pipeline/'
    abbr -a zoo 'cd ~/stripe/zoolander/'
    abbr -a viz 'cd ~/stripe/viz/'
    abbr -a gocode 'cd ~/stripe/gocode/'
    abbr -a redshift 'cd ~/stripe/redshift/'
    abbr -a dot 'cd ~/Documents/dotfiles/'
    abbr -a personal 'cd ~/personal/'

    abbr -a cimypy 'bazel build //tools/build_rules/linting/private/py_tools:mypy && ~/stripe/zoolander/bazel-bin/tools/build_rules/linting/private/py_tools/mypy'

    abbr -a pjk 'pay job:kill'
    abbr -a pjl 'pay job:list'

    # Postgres
    set -Ux PGDATA '/usr/local/var/postgres'

    # Pay stack shorcuts
    abbr -a ps 'pay stack'
end

functions -e fish_right_prompt

set -Ux PYENV_ROOT $HOME/.pyenv
pyenv init - | source

fish_add_path /opt/homebrew/bin
fish_add_path ~/.local/bin
fish_add_path /usr/local/bin
fish_add_path "$HOME/.cargo/bin"

abbr -a c clear
abbr -a e exit

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

zoxide init fish | source
abbr -a cd 'z'

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
abbr -a gswc 'git switch -c dmelchor/'
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
abbr -a gr&c 'git restore --staged . && git restore . && git clean -fdx'

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
abbr -a td 'todui'

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
function cached_neofetch
    set cache_file ~/.neofetch_cache
    if test -e $cache_file
	cat $cache_file
    else
	neofetch
    end
    
    fish -c "neofetch | string collect > $cache_file" &
end

function todo
    set output $(todui ls --format json)
    if test "$output" != "[]"
	# Todo list
	set output (todui ls | string collect)
	if test -n "$output"
	    echo -e "$output\n"
	end
    end
end


function reminders
    set output $(remind ls unread --json)
    if test "$output" != "[]"
	# Todo list
	set output (remind ls unread | string collect)
	if test -n "$output"
	    echo -e "$output\n"
	end
    end
end


function dotfiles_updates
    set cache_file ~/.dotfiles_updates_cache
    if test -e $cache_file
	cat $cache_file
    else
	dotfiles-update-checker
    end
    fish -c "dotfiles-update-checker | string collect > $cache_file" &
end

function fish_greeting
    echo
    cached_neofetch
    # todo
    reminders
    dotfiles_updates
end

source ~/.config/fish/autogen.fish
source ~/.config/fish/utils.fish
