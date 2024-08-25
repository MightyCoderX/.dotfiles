export "$(envsubst < .env)" # why doesn't this work???

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    exec Hyprland
fi

