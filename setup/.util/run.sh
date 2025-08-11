[[ -n "$DOTFILES_UTIL_RUN" ]] && return
DOTFILES_UTIL_RUN=1

# shellcheck disable=SC2218 # unrealted warning (possible bug) since this is calling a builtin
builtin source "$(dirname "${BASH_SOURCE[0]}")"/io.sh

# Run command if not in dry run else print it
run() {
	if [[ "$DRY_RUN" = 1 ]]; then
		info "[DRY_RUN]:" "$*"
	else
		eval "$*"
	fi
}

source() {
	[[ -z "$SCRIPT_DIR" ]] && {
		builtin source "$*"
		return
	}
	builtin source "${SCRIPT_DIR}$1"
}
export -f source

# Run single setup dir (add trailing slash)
# usage: run_setup <setup_dir>
run_setup() {
	local setup_dir="$1"

	[[ -d "$setup_dir" ]] || fatal "'$setup_dir' is not a valid directory"

	local setup_script="${setup_dir}setup"
	local config_script="${setup_dir}config"
	local shell_script
	shell_script="$(realpath "${setup_dir}shell.sh")"

	[[ "$ALL_PROGRAMS" == "0" ]] && { ask "Install '$setup_dir'?" || return; }

	export SCRIPT_DIR=$setup_dir
	bash "$setup_script"
	local setup_script_exit_code=$?
	local config_script_exit_code=0
	[[ -f "$config_script" ]] && {
		bash "$config_script"
		config_script_exit_code=$?
	}

	if [[ "$DRY_RUN" = "0" && -f "$shell_script" ]]; then
		if [ -n "$DOTFILES_RC_FILE" ] && [ -w "$DOTFILES_RC_FILE" ]; then
			echo "source \"$shell_script\"" >>"$DOTFILES_RC_FILE"
		else
			warn "RC_FILE='$DOTFILES_RC_FILE' not a valid path or file not writable"
		fi
	fi

	[[ "$setup_script_exit_code" = 0 && $config_script_exit_code = 0 ]]
}
