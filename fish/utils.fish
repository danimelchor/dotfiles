function db-del-autogen
    set list (databricks workspace list /Users/dmelchor@stripe.com --profile stripe-prod-pdx-stripe -o json)
    # Use jq to parse the json and find all objects where the path key contains JSON
    set paths (echo $list | jq -r '.[] | select(.path | contains("JSON")) | .path')

    # Loop through the paths and delete them
    for path in $paths
	echo "Deleting $path"
	databricks workspace delete "$path" --profile stripe-prod-pdx-stripe
    end
end

function btest
    set target $argv[1]
    for arg in $argv
	switch $arg
	    case '-k=*'
		set k_option "--test_arg=-k=$(string replace -- '-k=' '' $arg)"
	    case '--durations=*'
		set durations_option "--test_arg=--durations=$(string replace -- '--durations=' '' $arg)"
	    case '*'
		continue
	end
    end
    
    bazel test $target --cache_test_results=no --test_arg=-vv --test_output=all $k_option $durations_option
end
