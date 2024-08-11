#!/bin/sh

# while read -r directory events filename; do
inotifywait -e close_write -m . |
while read -r _ events filename; do
    [ "$events" != "CLOSE_WRITE,CLOSE" ] && continue

    echo "before" "$events" "$filename"

    if [ "$filename" != "config.jsonc" ] && [ "$filename" != "style.css" ]; then 
        continue
    fi

    echo "$events $filename"

    killall waybar
    hyprctl dispatch exec -- waybar
done

