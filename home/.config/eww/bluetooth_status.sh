#!/bin/sh

bluetoothctl list | grep default | cut -d' ' -f2 | xargs bluetoothctl show | sed -En '/PowerState/ s/\s+PowerState: //p'
