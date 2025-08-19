#!/usr/bin/env bash

# Trap Ctrl-C and echo for a clean output
trap 'echo; exit' INT

###################
#  IO Functions   #
###################
ESC=$'\x1b'
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
RESET="${ESC}[0m"

info() {
	printf "${BLUE}[INFO] %b\n${RESET}" "$*"
}

success() {
	printf "${GREEN}[SUCCESS] %b\n${RESET}" "$*"
}

warn() {
	printf "${YELLOW}[WARN] %b\n${RESET}" "$*" >&2
}

fatal() {
	printf "${RED}[FATAL] %b\n${RESET}" "$*" >&2
	exit 1
}

ask() {
	${CONFIG[assume_yes]} && return

	local resp="n"
	read -rp "$1 (y/N): " </dev/tty
	[[ -n "$REPLY" ]] && resp="$REPLY"

	[[ "$resp" = "y" ]]
}

print_usage() {
	cat <<-EOF
		usage: $0 [OPTIONS]

		Options:
		   -h, --help               prints this message
		   -s, --shell              select shell to configure for interactive use (default bash)
		   -p, --all-programs       install and/or setup all programs without asking for each one
		   -d, --all-home-files     symlink all home/.* files to $HOME
		   -n, --no-dry             disables dry run

	EOF
	exit 0
}

#############
# Dir check #
#############
if [[ ! -d ./setup ]]; then
	fatal "No ./setup directory found. This script must be run from the directory it's in!"
fi

#######################
#  Argument parsing   #
#######################

parse_args() {
	local temp
	temp=$(getopt -o 'hspdny' --long 'help,shell,all-programs,all-home-files,no-dry,assume-yes' -n "$0" -- "$@")

	# shellcheck disable=2181 # we need the output from getopt
	if [ $? -ne 0 ]; then
		exit 1
	fi

	eval set -- "$temp"

	###########
	# OPTIONS #
	###########

	declare -gA CONFIG=(
		[shell]="bash"         # -s, --shell
		[all_programs]=false   # -p, --all-programs
		[all_home_files]=false # -d, --all-home-files
		[dry_run]=true         # -n, --no-dry
		[assume_yes]=false     # -y, --assume-yes
	)

	while true; do
		case "$1" in
		'-h' | '--help')
			print_usage
			;;
		'-s' | '--shell')
			CONFIG[shell]=$2
			shift 2
			;;
		'-p' | '--all-programs')
			CONFIG[all_programs]=true
			shift
			;;
		'-d' | '--all-home-files')
			CONFIG[all_home_files]=true
			shift
			;;
		'-n' | '--no-dry')
			CONFIG[dry_run]=false
			shift
			;;
		'-y' | '--assume-yes')
			CONFIG[assume_yes]=true
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

	info "Current config"
	local opt
	for opt in "${!CONFIG[@]}"; do
		info "\t $opt = ${CONFIG[$opt]}"
	done
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
		success "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Install one or more dnf packages
install_dnf() {
	[[ ! "$DISTRO_ID" = "fedora" ]] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run "sudo dnf install -y $* >/dev/null"; then
		success "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Run command if not in dry run else print it
run() {
	if ${CONFIG[dry_run]}; then
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

	if ! ${CONFIG[all_programs]}; then
		ask "Run '$setup_dir'?" || return
	fi

	# shellcheck disable=2034 # used ins sourced file
	SCRIPT_DIR=$setup_dir

	# shellcheck source=./setup/.template/setup.bash
	source "$setup_script"
	setup
	local setup_script_exit_code=$?

	local config_script_exit_code=0
	if command -v config >/dev/null; then # check if function config exists
		config
		config_script_exit_code=$?
	fi

	# remove script's functions from scope
	unset setup config

	if ! ${CONFIG[dry_run]} && [[ -f "$shell_script" ]]; then
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

	if ! ${CONFIG[dry_run]} && [[ -f "$DOTFILES_RC_FILE" ]]; then
		echo "### SETUP SCRIPT ###" >>"$DOTFILES_RC_FILE"
	fi

	local setup_dir
	for setup_dir in ./setup/*/; do
		[[ "$setup_dir" = "./setup/00_shell/" ]] && continue
		if run_setup "$setup_dir"; then
			success "Setup $setup_dir"
		else
			warn "Failed to setup $setup_dir"
		fi
	done

	success "Installed and/or setup programs in ./setup"

	echo
}

setup_home() {
	ask "Install ./home/.* in $HOME/?" || return

	info "\nCopying dot files to home\n"

	[[ ! -d ./home ]] && warn "Directory ./home not found, skipping install of $$HOME/.* files" && return

	local local_path target_path
	for local_path in ./home/.*; do
		local_path="$(basename "$local_path")"
		target_path="$HOME/$local_path"

		if ! ${CONFIG[all_home_files]}; then
			ask "Symlink $local_path -> $target_path?" || continue
		fi

		run ln -s "$(realpath "$local_path")" "$target_path"
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
