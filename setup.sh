#!/usr/bin/env bash

print_usage() {
    printf "usage: %s [--no-dry] [--all]\n" "$0" >&2
    exit 1
}

TEMP=$(getopt -o 'an' --long 'all,no-dry' -n "$0" -- "$@")

if [ $? -ne 0 ]; then
    exit 1
fi

eval set -- "$TEMP"
unset TEMP

ALL_PROGRAMS="0"
DRY_RUN="1"
while true; do
    case "$1" in
        '-a'|'--all')
            ALL_PROGRAMS="1"
            shift
        ;;
        '-n'|'--no-dry')
            DRY_RUN="0"
            shift
        ;;
        '--')
            shift
            break
        ;;
        *)
            print_usage
        ;;
    esac
done

printf "DRY_RUN: "
[ "$DRY_RUN" = "1" ] && printf on || printf "off"

printf "  ALL: "
[ "$ALL_PROGRAMS" = "1" ] && printf on || printf off
echo

ask() {
    resp="n"
    read -rp "$1 (y/N): " < /dev/tty
    [ -n "$REPLY" ] && resp="$REPLY" 

    [ "$resp" = "y" ]
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
    [ "$DRY_RUN" = "0" ] && echo "### SETUP SCRIPT ###" >> "$RC_FILE"
    for setup_dir in ./setup/*/; do
        setup_script="${setup_dir}setup"
        shell_script="$(realpath "${setup_dir}shell.sh")"

        [ "$ALL_PROGRAMS" == "0" ] && { ask "Install '$setup_dir'?" || continue; }

        run "$setup_script"
        if [ "$DRY_RUN" = "0" ]; then
            echo "source \"$shell_script\"" >> "$RC_FILE"
        fi
    done
fi

#TODO do this manually in each setup file, 
# so only configs of installed programs are installed
# some programs may already be installed so maybe add an option to toggle the installation
# of all configs, just install by default all configs of installed programs
# add a couple of flags to manage all of that (take inspiration from /usr/share/doc/util-linux/getopt-example.bash)

# echo -e "\nCopying misc config files\n"
# find .config home -mindepth 1 -maxdepth 1 | while read -r local_path; do
#     if [ "$(dirname "$local_path")" = "home" ]; then
#         local_path="$(basename "$local_path")"
#     fi

#     ask "Copy $local_path?" || continue

#     run ln -s "$(realpath "$local_path")" "$HOME/$local_path"
# done

