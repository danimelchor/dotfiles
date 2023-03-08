NAME=$(~/.local/bin/rust-todo ls --format json --filter today | jq -r '.[0].name')
LENGTH=$(~/.local/bin/rust-todo ls --format json --filter today | jq length)

if [ "$NAME" = "null" ]; then
  LABEL="No tasks for today"
  ICON="󰄲"
elif [ "$LENGTH" -gt 1 ]; then
  LABEL="$NAME (+$(($LENGTH - 1)))"
  ICON="󰄱"
else
  LABEL="$NAME"
  ICON="󰄱"
fi

# Switched them around because I want the icon to be on the right
sketchybar -m --set todo             \
  label="$ICON"                          \
  icon="$LABEL"                      
