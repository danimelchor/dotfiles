function quicka
    set alias_name $argv[1]
    set alias_command $argv[2]

    if test -z "$alias_name"
	echo "Usage: quicka <alias_name> <alias_command>"
	return 1
    end

    if test -z "$alias_command"
	echo "Usage: quicka <alias_name> <alias_command>"
	return 1
    end
    
    # Add the alias to config.fish
    echo "abbr -a $alias_name \"$alias_command\"" >> ~/.config/fish/autogen.fish
    
    # Add the alias to the current shell environment
    abbr -a $alias_name "$alias_command"
end

# AUTOGEN ALIASES:
abbr -a lint "~/stripe/zoolander/dev/lint"
