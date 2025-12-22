#!/bin/sh

send_notification() {
    notify-send -i "bluetooth" -a "System" "Bluetooth" "$1"
}

connected_devices="$(bluetoothctl devices Connected | grep '^Device')"
trusted_devices="$(bluetoothctl devices Trusted | grep '^Device')"

if [ -z "$connected_devices" ]; then
    first_device="$(echo "$trusted_devices" | head -n 1)"
    first_device_name="$(printf '%s' "$first_device" | cut -d" " -f 3-)"
    first_device_mac="$(printf '%s' "$first_device" | cut -d" " -f 2)"

    send_notification "Connecting to $first_device_name"

    if bluetoothctl connect "$first_device_mac"; then
        send_notification "Connected to $first_device_name"
    else
        send_notification "Failed to connect to $first_device_name"
    fi
else
    first_device="$(echo "$connected_devices" | head -n 1)"
    first_device_name="$(printf '%s' "$first_device" | cut -d" " -f 3-)"
    first_device_mac="$(printf '%s' "$first_device" | cut -d" " -f 2)"

    send_notification "Disconnecting $first_device_name..."

    if bluetoothctl disconnect "$first_device_mac"; then
        send_notification "Disconnected $first_device_name"
    else
        send_notification "Failed to disconnect $first_device_name"
    fi
fi
