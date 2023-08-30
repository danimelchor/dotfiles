if [ -d ~/stripe ]; then
    sketchybar --add alias "MeetingBar,Item-0" e \
               --rename "MeetingBar,Item-0" cron \
               --set cron width=30 \
                          padding_left=7 \
                          alias.update_freq=60
else
    sketchybar --add alias "Cron,Item-0" e \
               --rename "Cron,Item-0" cron \
               --set cron width=30 \
                          padding_left=7 \
                          alias.update_freq=60
fi
