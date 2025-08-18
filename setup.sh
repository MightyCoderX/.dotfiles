#!/usr/bin/env bash

# Trap Ctrl-C and echo for a clean output
trap 'echo; exit' INT

###################
#  IO Functions   #
###################

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
	[[ -n "$REPLY" ]] && resp="$REPLY"

	[[ "$resp" = "y" ]]
}

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

#############
# Dir check #
#############
[[ ! -d ./setup ]] && {
	printf "No ./setup directory found. This script must be run from the directory it's in!\n" >&2
	exit 1
}

#######################
#  Argument parsing   #
#######################

parse_args() {
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
	[[ "$DRY_RUN" = 1 ]] && printf on || printf off

	printf "  ALL: "
	[[ "$ALL_PROGRAMS" = 1 ]] && printf on || printf off
	echo
}

######################
#  Running scripts   #
######################
while read -r; do
	declare DISTRO_"$REPLY"
done </etc/os-release
# shellcheck disable=2034 # used in sourced file
DOTFILES_PATH="$(dirname "$(realpath "$0")")"

install_pacman() {
	[[ ! "$DISTRO_ID" = "arch" ]] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run "sudo pacman -S --noconfirm --needed $* >/dev/null"; then
		info "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Install one or more dnf packages
install_dnf() {
	[[ ! "$DISTRO_ID" = "fedora" ]] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run "sudo dnf install -y $* >/dev/null"; then
		info "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Run command if not in dry run else print it
run() {
	if [[ "$DRY_RUN" = "1" ]]; then
		info "[DRY_RUN]:" "$*"
	else
		eval "$*"
	fi
}

# Run single setup dir
# usage: run_setup <setup_dir>
run_setup() {
	local setup_dir="${1%/}" # remove trailing slash if present

	[[ -d "$setup_dir" ]] || fatal "'$setup_dir' is not a valid directory"

	local setup_script="${setup_dir}/setup.bash"
	local shell_script
	shell_script="$(realpath "${setup_dir}/shell.sh")"

	[[ "$ALL_PROGRAMS" == "0" ]] && { ask "Install '$setup_dir'?" || return; }

	# shellcheck disable=2034 # used ins sourced file
	SCRIPT_DIR=$setup_dir

	# remove previous script's functions
	unset setup config

	# shellcheck source=./setup/.template/setup.bash
	source "$setup_script"
	setup
	local setup_script_exit_code=$?
	config
	local config_script_exit_code=$?

	if [[ "$DRY_RUN" = "0" && -f "$shell_script" ]]; then
		if [[ -n "$DOTFILES_RC_FILE" && -w "$DOTFILES_RC_FILE" ]]; then
			echo "source \"$shell_script\"" >>"$DOTFILES_RC_FILE"
		else
			warn "RC_FILE='$DOTFILES_RC_FILE' not a valid path or file not writable"
		fi
	fi

	[[ "$setup_script_exit_code" = 0 && $config_script_exit_code = 0 ]]
}

setup_programs() {
	ask "Install and/or setup programs?" || return

	info "Installing and/or setting up programs in ./setup"

	[[ ! -d ~/.config ]] && run mkdir ~/.config

	[[ "$DRY_RUN" = "0" && -f "$DOTFILES_RC_FILE" ]] && echo "### SETUP SCRIPT ###" >>"$DOTFILES_RC_FILE"
	for setup_dir in ./setup/*/; do
		[[ "$setup_dir" = "./setup/00_shell/" ]] && continue
		run_setup "$setup_dir"
	done

	info "Installed and/or setup programs in ./setup"

	echo
}

setup_home() {
	ask "Install ./home/.* in $HOME/?" || return

	info "\nCopying dot files to home\n"

	[[ ! -d ./home ]] && warn "Directory ./home not found, skipping install of $$HOME/.* files" && return

	find home -mindepth 1 -maxdepth 1 | while read -r local_path; do
		local_path="$(basename "$local_path")"

		ask "Copy $local_path?" || continue

		run ln -s "$(realpath "$local_path")" "$HOME/$local_path"
	done

	echo
}

main() {
	parse_args "$@"
	run_setup ./setup/00_shell
	setup_programs
	setup_home
}

main "$@"
