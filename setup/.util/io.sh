[ -n "$DOTFILES_UTIL_IO" ] && return
DOTFILES_UTIL_IO=1

info() {
    printf '[INFO] %s\n' "$*"
}

warn() {
    printf '[WARN] %s\n' "$*" >&2
}

fatal() {
    printf '[FATAL] %s\n' "$*" >&2
    exit 1
}

ask() {
    resp="n"
    read -rp "$1 (y/N): " </dev/tty
    [ -n "$REPLY" ] && resp="$REPLY"

    [ "$resp" = "y" ]
}
