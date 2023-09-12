function npytest  
    for i in (seq $argv[1])
	fish -c "set output (pytest -q | string collect) &&
	set_color blue &&
	echo -e \"\\n\\n==== Running test $i ====\" &&
	set_color normal &&
	echo -e \$output &"
    end  
end


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


function version_bump
    # Find version r"(\d+.\d+.\d+)" from the BUILD.bazel file in the current directory
    if test -f BUILD.bazel
 	set curr_version (grep -oE '(\d+\.\d+\.\d+)' BUILD.bazel)
    else
	echo "No BUILD.bazel file found in current directory"
	return 1
    end

    # Prompt for new version
    echo "Current version is $curr_version"
    read -P "Enter new version: " new_version

    # Convert versions to regex
    set curr_version_regex (echo $curr_version | sed 's/\./\\./g')
    set new_version_regex (echo $new_version | sed 's/\./\\./g')

    # Replace version with new version in all files in cwd
    find . -type f -exec sed -i '' "s/$curr_version_regex/$new_version_regex/g" {} +;
end
