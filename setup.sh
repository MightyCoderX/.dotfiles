#!/usr/bin/env bash

trap 'echo; exit' INT

[ ! -d ./setup ] && {
	printf "No ./setup directory found. This script must be run from the directory it's in!\n" >&2
	exit 1
}

source ./setup/.util/io.sh

#######################
#  Argument parsing   #
#######################
print_usage() {
	cat <<-EOF
		usage: $0 [--no-dry] [--all]

		Options:
		   --help    prints this message
		   --no-dry  disables dry run
		   --all     install and/or setup all programs without asking for each one

	EOF
	exit 0
}

TEMP=$(getopt -o 'han' --long 'help,all,no-dry' -n "$0" -- "$@")

# shellcheck disable=2181 # we need the output from getopt
if [ $? -ne 0 ]; then
	exit 1
fi

eval set -- "$TEMP"
unset TEMP

ALL_PROGRAMS=0
DRY_RUN=1
while true; do
	case "$1" in
	'-h' | '--help')
		print_usage
		;;
	'-a' | '--all')
		ALL_PROGRAMS=1
		shift
		;;
	'-n' | '--no-dry')
		DRY_RUN=0
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
[ "$DRY_RUN" = 1 ] && printf on || printf off

printf "  ALL: "
[ "$ALL_PROGRAMS" = 1 ] && printf on || printf off
echo

export ALL_PROGRAMS DRY_RUN

######################
#  Running scripts   #
######################
DOTFILES_PATH="$(dirname "$(realpath "$0")")"
export DOTFILES_PATH

source ./setup/.util/run.sh

setup_programs() {
	ask "Install and/or setup programs?" || return

	info "Installing and/or setting up programs in ./setup"

	[ ! -d ~/.config ] && run mkdir ~/.config

	[ "$DRY_RUN" = "0" ] && [ -f "$DOTFILES_RC_FILE" ] && echo "### SETUP SCRIPT ###" >>"$DOTFILES_RC_FILE"
	for setup_dir in ./setup/*/; do
		[ "$setup_dir" = "./setup/00_shell/" ] && continue
		run_setup "$setup_dir"
	done

	info "Installed and/or setup programs in ./setup"

	echo
}

setup_shell_configs() {
	ask "Source shell configurations in respective rc files?" || return

	info "Sourcing shell configurations"

	[ ! -d ./shell ] && warn "Directory ./shell not found, skipping" && return

	for shell_conf in ./shell/*.{sh,bash}; do
		echo "source $(realpath "$shell_conf")" >>~/.bashrc
	done

	[ -f ~/.zshrc ] && for shell_conf in ./shell/*.{sh,zsh}; do
		echo "source $(realpath "$shell_conf")" >>~/.zshrc
	done

	info "Sourced all shell configurations"

	echo
}

setup_home() {
	ask "Install ./home/.* in $HOME/?" || return

	info "\nCopying dot files to home\n"

	[ ! -d ./home ] && warn "Directory ./home not found, skipping install of $$HOME/.* files" && return

	find home -mindepth 1 -maxdepth 1 | while read -r local_path; do
		local_path="$(basename "$local_path")"

		ask "Copy $local_path?" || continue

		run ln -s "$(realpath "$local_path")" "$HOME/$local_path"
	done

	echo
}

run_setup ./setup/00_shell/
setup_shell_code=$?
[ -f /tmp/dotfiles_vars ] && eval "export $(cat /tmp/dotfiles_vars)"

[ "$setup_shell_code" = 0 ] && setup_shell_configs
setup_programs
setup_home
