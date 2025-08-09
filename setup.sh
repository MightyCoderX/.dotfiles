#!/usr/bin/env bash
[ ! -d ./setup ] && {
	printf "No ./setup directory found. This script must be run from the directory it's in!\n" >&2
	exit 1
}

source ./setup/.util/io.sh

#######################
#  Argument parsing   #
#######################
print_usage() {
    fatal "usage: $0 [--no-dry] [--all]\n"
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
    '-a' | '--all')
        ALL_PROGRAMS="1"
        shift
        ;;
    '-n' | '--no-dry')
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
[ "$DRY_RUN" = "1" ] && printf on || printf off

printf "  ALL: "
[ "$ALL_PROGRAMS" = "1" ] && printf on || printf off
echo

#######################
######################
#  Running scripts   #
######################
DOTFILES_PATH="$(dirname "$(realpath "$0")")"

source ./setup/.util/run.sh

run_setup ./setup/00_shell/

if ask "Install and setup programs?"; then
    [ "$DRY_RUN" = "0" ] && echo "### SETUP SCRIPT ###" >>"$RC_FILE"
    for setup_dir in ./setup/*/; do
        [ "$setup_dir" = "./setup/00_shell/" ] && continue
        run_setup "$setup_dir"
    done
fi

if ask "Install shell configurations?"; then
    for shell_conf in ./shell/*.{"$SHELL",sh}; do
        echo "$shell_conf"
    done
fi

info "\nCopying dot files to home\n"
find home -mindepth 1 -maxdepth 1 | while read -r local_path; do
    local_path="$(basename "$local_path")"

    ask "Copy $local_path?" || continue

    run ln -s "$(realpath "$local_path")" "$HOME/$local_path"
done
