#!/bin/sh

STATUS_FILE=/tmp/touchpad_enabled

[ ! -f "$STATUS_FILE" ] && echo false > "$STATUS_FILE"

echo "$([ "$(cat "$STATUS_FILE")" == "true" ] && echo false || echo true)" > "$STATUS_FILE"

status="$(cat "$STATUS_FILE")"

notify-send "Touchpad" "Enabled: $status" -a "Input" -i /usr/share/icons/Adwaita/symbolic/devices/input-touchpad-symbolic.svg
#hyprctl keyword '$TOUCHPAD_ENABLED' "$status" -r

