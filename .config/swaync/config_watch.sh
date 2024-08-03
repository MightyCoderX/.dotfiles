#!/bin/sh

killall swaync
hyprctl dispatch exec -- GTK_DEBUG=interactive swaync

# while read -r directory events filename; do
inotifywait -e close_write -m . |\
while read -r _ events filename; do
    [ "$events" != "CLOSE_WRITE,CLOSE" ] && continue

    if [ "$filename" != "config.json" ] && [ "$filename" != "style.css" ]; then 
        continue
    fi

    echo "$events $filename"
    swaync-client --reload-css
    swaync-client --reload-config
done
