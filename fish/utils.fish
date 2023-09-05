function npytest  
    for i in (seq $argv[1])
	fish -c "set output (pytest -q | string collect) &&
	set_color blue &&
	echo -e \"\\n\\n==== Running test $i ====\" &&
	set_color normal &&
	echo -e \$output &"
    end  
end
