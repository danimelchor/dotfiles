abbr -a proj 'cd ~/projects'
abbr -a c clear
abbr -a e exit
abbr -a bu 'cd ~/BU/spring2023'
abbr -a survey '~/projects/emmanuel/venv/bin/python3 ~/projects/emmanuel/survey.py'

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

if command -v z > /dev/null
    abbr -a cd 'z'
end

function v
    if test -z $argv[1]
        nvim .
    else
        nvim $argv[1]
    end
end

# Git aliases
abbr -a gaa 'git add --all'
abbr -a gcm 'git commit -m'
abbr -a gs 'git status'
abbr -a gp 'git push'

# Python aliases
abbr -a ve "source venv/bin/activate.fish"
abbr -a dve "deactivate"
abbr -a pipr "pip install -r requirements.txt"

# Docker compose aliases
abbr -a dcu "docker-compose up -d;dclogs"
abbr -a dclogs "docker-compose logs --follow"
abbr -a dcr "docker-compose restart $1"
abbr -a dcrb "docker-compose up --no-deps --detach --build $1;dclogs"
abbr -a dcprune "docker system prune -a -f"

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# tmux sessionizer
bind \cf tmux-sessionizer
setenv FZF_DEFAULT_OPTS "--border --color 'pointer:#B3E1A7,bg+:-1,fg+:#B3E1A7'"

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

zoxide init fish | source

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color blue
	echo -n (id -un)
	if [ $PWD != $HOME ]
		set_color brblack
		echo -n ':'
		set_color yellow
		echo -n (basename $PWD)
	end
	set_color green
	printf '%s ' (__fish_git_prompt)
	set_color red
	echo -n '~ '
	set_color normal
end

function fish_greeting
	neofetch

	set_color green
	echo "Today's tasks:"
	set_color normal
	todui ls --date-filter today-and-past
end
