#!/bin/sh

notifications=$(dunstctl history | jq -rs '.[] | .data[0] | .[] | map_values( .data ) | .message + ."\n"')

notify-send 'Dunst History' "\n$notifications"


