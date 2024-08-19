#!/bin/sh

handle() {
    echo "$1"
    case $1 in
        workspace*)
            
            ;;
    esac
}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | 
    while read -r line; do handle "$line"; done
