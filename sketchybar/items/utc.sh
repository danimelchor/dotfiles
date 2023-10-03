if [ -d ~/stripe ]; then
    sketchybar --add alias "UTCMenuClock,Item-0" q \
               --rename "UTCMenuClock,Item-0" utc \
               --set utc width=30 \
                     padding_left=7 \
                     alias.update_freq=60 \
                     alias.color=0xFFFFFFFF
fi
