[ -n "$DOTFILES_UTIL_IO" ] && return
DOTFILES_UTIL_IO=1

info() {
	printf '[INFO] %b\n' "$*"
}

warn() {
	printf '[WARN] %b\n' "$*" >&2
}

fatal() {
	printf '[FATAL] %b\n' "$*" >&2
	exit 1
}

ask() {
	resp="n"
	read -rp "$1 (y/N): " </dev/tty
	[ -n "$REPLY" ] && resp="$REPLY"

	[ "$resp" = "y" ]
}
