
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    exec Hyprland
fi

