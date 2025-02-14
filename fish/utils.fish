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
