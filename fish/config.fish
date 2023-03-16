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

# Git aliases
abbr -a gaa 'git add --all'
abbr -a gcm 'git commit -m'
