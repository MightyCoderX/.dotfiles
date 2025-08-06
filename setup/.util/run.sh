[ -n "$DOTFILES_UTIL_RUN" ] && return
DOTFILES_UTIL_RUN=1

source ./io.sh

# Run command if not in dry run else print it
run() {
    if [ "$DRY_RUN" = "1" ]; then
        info "[DRY_RUN]:" "$*"
    else
        eval "$*"
    fi
}

# Run single setup dir (add trailing slash)
# usage: run_setup <setup_dir>
run_setup() {
    local setup_dir="$1"

    [ -d "$setup_dir" ] || die "'$setup_dir' is not a valid directory"

    local setup_script="${setup_dir}setup"
    local shell_script
    shell_script="$(realpath "${setup_dir}shell.sh")"

    [ "$ALL_PROGRAMS" == "0" ] && { ask "Install '$setup_dir'?" || return; }

    run "$setup_script"
    if [ "$DRY_RUN" = "0" ]; then
        if [ -n "$RC_FILE" ] && [ -w "$RC_FILE" ]; then
            echo "source \"$shell_script\"" >>"$RC_FILE"
        else
            warn "RC_FILE='$RC_FILE' not a valid path or file not writeable"
        fi
    fi

}
