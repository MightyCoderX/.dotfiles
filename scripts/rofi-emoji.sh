#!/bin/sh

unipicker --command 'rofi -theme-str "window { width: 50%; height: 60%; } listview { columns: 1; }" -dmenu -p Emoji'\
    | wl-copy
