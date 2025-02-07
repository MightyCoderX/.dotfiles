#!/bin/sh

[ $# -lt 2 ] && { printf 'usage: %s <yyyy-mm-dd hh:mm:ss> <label>\n' "$0">&2; exit 1; }

time="$1" # format yyyy-mm-dd hh:mm:ss
label="$2"

sound_file=/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga

systemd-run --user --on-calendar="$time" --\
    sh -c "notify-send \"Alarm\" -a \"Systemd\" \"$label\"; pw-play \"$sound_file\""

