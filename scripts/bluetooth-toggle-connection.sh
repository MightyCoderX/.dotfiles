#!/bin/sh

send_notification() {
    notify-send -i "bluetooth" -a "System" "Bluetooth" "$1"
}

connected_devices="$(bluetoothctl devices Connected)"
trusted_devices="$(bluetoothctl devices Trusted)"

if [ -z "$connected_devices" ]; then
    first_device="$(printf "$trusted_devices\n" | head -n 1)"
    first_device_name="$(printf "$first_device" | cut -d" " -f 3-)"
    first_device_mac="$(printf "$first_device" | cut -d" " -f 2)"

    send_notification "Connecting to $first_device_name"

    if bluetoothctl connect "$first_device_mac"; then
        send_notification "Connected to $first_device_name"
    else
        send_notification "Failed to connect to $first_device_name"
    fi
else
    first_device="$(printf "$connected_devices\n"| head -n 1)"
    first_device_name="$(printf "$first_device" | cut -d" " -f 3-)"
    first_device_mac="$(printf "$first_device" | cut -d" " -f 2)"

    send_notification "Disconnecting $first_device_name..."

    if bluetoothctl disconnect "$first_device_mac"; then
        send_notification "Disconnected $first_device_name"
    else
        send_notification "Failed to disconnect $first_device_name"
    fi
fi
