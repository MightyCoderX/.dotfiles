#!/bin/sh -Eeu

status_file=/tmp/touchpad_status
touchpad="${1:-"msnb0001:00-06cb:7e7e-touchpad"}"

status="$(cat "$status_file" || echo 0)"

case "$status" in
    0)
        status=1
        status_str="Enabled"
        ;;
    1)
        status=0
        status_str="Disabled"
        ;;
    *)
        if [ -t 0 ]; then
            printf 'Invalid status `%s` in status file `%s`\n' "$status" "$status_file" >&2;
            exit 1
        else
            rm "$status_file"
        fi
esac

notify-send --transient "Touchpad" "$status_str" -a "System" -i /usr/share/icons/Adwaita/symbolic/devices/input-touchpad-symbolic.svg
hyprctl keyword "device[$touchpad]:enabled" "$status"

echo "$status" > "$status_file"

