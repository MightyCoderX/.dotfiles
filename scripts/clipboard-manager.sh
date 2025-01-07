#!/bin/sh

cliphist list\
    | rofi -dmenu -p "clipboard" -theme-str "window { width: 60%; } listview { columns: 1; }"\
    | cliphist decode | wl-copy
