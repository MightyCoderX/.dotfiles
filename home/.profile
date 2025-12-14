. .env

if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
	exec start-hyprland
fi

[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
