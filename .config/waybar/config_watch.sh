#!/bin/sh

# while read -r directory events filename; do
inotifywait -e close_write,moved_to,create -m . |
while read -r _ events filename; do
    echo "$events $filename"
    killall waybar
    hyprctl dispatch exec -- GTK_DEBUG=interactive waybar
done

