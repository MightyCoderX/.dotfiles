#!/usr/bin/env bash

[ $# -lt 1 ] && { printf "usage: %s [--dry]\n" "$0" >&2; exit 1; }

DRY_RUN="0"
if [ "$1" = "--dry" ]; then
    DRY_RUN="1"
else
    printf "error: invalid option '%s', run without args for usage\n" "$1"
    exit 1
fi

ask() {
    read -rp "$1 (Y/n): " resp < /dev/tty
    [ -z "$resp" ] || [ "$resp" = "y" ]
}

run() {
    if [ "$DRY_RUN" = "1" ]; then
        echo "[DRY_RUN]:" "$*"
    else
        eval "$*"
    fi
}

RC_FILE=~/.bashrc
read -rp "Where is your shell's rc file? (default: ~/.bashrc): "

[ "$REPLY" ] && RC_FILE="$REPLY"

if [ ! "$RC_FILE" ]; then
    echo "rc file path needed to run setup scripts"
    exit 1
fi

if [ ! -w "$RC_FILE" ]; then
    printf "file '%s' doesn't exist or is not writeable\n" "$RC_FILE"
fi

if ask "Install and setup programs?"; then
    echo "### SETUP SCRIPT ###" >> "$RC_FILE"
    for setup_dir in ./setup/*/; do
        setup_script="${setup_dir}setup"
        shell_script="$(realpath "${setup_dir}shell.sh")"

        run "$setup_script"
        run echo "source \"$shell_script\"" >> "$RC_FILE"
    done
fi

echo -e "\nCopying misc config files\n"
find .config home -mindepth 1 -maxdepth 1 | while read -r local_path; do
    if [ "$(dirname "$local_path")" = "home" ]; then
        local_path="$(basename "$local_path")"
    fi

    ask "Copy $local_path?" || continue

    run ln -s "$(realpath "$local_path")" "$HOME/$local_path"
done

