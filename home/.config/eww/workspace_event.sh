#!/bin/sh

handle() {
    case $1 in
        workspacev*);;
        workspace* | focusedmon*)
            hyprctl activeworkspace -j | jq -c
            ;;
    esac
}

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
