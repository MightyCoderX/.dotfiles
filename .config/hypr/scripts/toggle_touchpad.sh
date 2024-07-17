#!/bin/sh

[ -z $TOUCHPAD_ENABLED ] && $TOUCHPAD_ENABLED=false

[ "$TOUCHPAD_ENABLED" == "false" ] && TOUCHPAD_ENABLED=true || TOUCHPAD_ENABLED=false

notify-send "Touchpad" $status

hyprctl keyword '$TOUCHPAD_ENABLED' "$TOUCHPAD_ENABLED" -r

export TOUCHPAD_ENABLED
