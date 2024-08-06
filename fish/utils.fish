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

function awsync
    # Runs `pay await-sync --files && <cmd>`
    set files (pay await-sync --files)
    if test -n "$files"
    	echo "Files not synced: $files"
    	return 1
    end
    printf "Files synced. Running: "
    $argv
end

function gif
    set file $argv[1]
    set size $argv[2]
    echo "Converting $file to gif"
    set file_name_no_ext (path change-extension '' $file)
    ffmpeg -i $file -r 10 -s $size -filter_complex "[0:v] split [a][b];[a] palettegen [p];[b][p] paletteuse" \
          -loop 0 "tmp_$file_name_no_ext.gif"
    gifsicle -O3 "tmp_$file_name_no_ext.gif" -o "$file_name_no_ext.gif"
    rm "tmp_$file_name_no_ext.gif"
end

function speed-up
    set file $argv[1]
    set speed $argv[2]

    echo "Speeding up $file by $speed"
    set file_name_no_ext (path change-extension '' $file)
    ffmpeg -i $file -filter:v "setpts=PTS/$speed" "tmp_$file_name_no_ext.mp4"
    mv "tmp_$file_name_no_ext.mp4" "$file_name_no_ext.mp4"
end

function show-master
    set file $argv[1]
    git show origin/master:$file > $file
end
