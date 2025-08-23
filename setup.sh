#!/usr/bin/env bash

# Enable nullglob to get an empty string if glob doesn't match
shopt -s nullglob

# Print empty line and exit on Ctrl-C
trap 'echo; exit' INT

###################
#  IO Functions   #
###################
ESC=$'\x1b'
GRAY="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
RESET="${ESC}[0m"

ITALIC="${ESC}[3m"
LIGHTER="${ESC}[1m"
DARKER="${ESC}[2m"

info() {
	printf "${BLUE}[INFO] %b${RESET}\n" "$*"
}

debug() {
	printf "${DARKER}%b${RESET}\n" "$*"
}

success() {
	printf "${GREEN}[SUCCESS] %b${RESET}\n" "$*"
}

warn() {
	printf "${YELLOW}[WARN] %b${RESET}\n" "$*" >&2
}

fatal() {
	printf "${RED}[FATAL] %b${RESET}\n" "$*" >&2
	exit 1
}

ask() {
	${CONFIG[assume_yes]} && return

	local resp="n"
	read -rp "$1 (y/N): " </dev/tty
	[[ -n "$REPLY" ]] && resp="$REPLY"

	[[ "$resp" = "y" || -t 1 ]]
}

print_usage() {
	cat <<-EOF
		usage: $0 [OPTIONS] [PROGRAM]

		Options:
		   -h, --help               prints this message
		   -l, --list               list all programs to setup and/or config
		   -c, --config-only        only run config function of setup scripts
		   -s, --shell              select shell to configure for interactive use (default bash)
		   -P, --all-programs       install and/or setup all programs without asking for each one
		   -d, --all-home-files     symlink all home/.* files to $HOME/
		   -n, --no-dry             disables dry run
		   -y, --assume-yes         automatically selects yes when a y/n prompt should show

	EOF
	exit 0
}

declare -A programs

for setup_prog in ./setup/*/setup.bash; do
	setup_prog=${setup_prog%/**} # removes /setup.sh from end of path (dirname equivalent)
	prog_name=${setup_prog##**/} # remove all folders except last (basename equivalent)
	prog_name=${prog_name#**_}
	programs[$prog_name]=$setup_prog
done
unset setup_prog prog_name

print_setup_list() {
	local setup_prog prog_name
	printf "%s\n" "${!programs[@]}"
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
	temp=$(getopt -o 'hlcs:Pdny' --long 'help,list,config-only,shell:,all-programs,all-home-files,no-dry,assume-yes' -n "$0" -- "$@")

	# shellcheck disable=2181 # we need the output from getopt
	if [ $? -ne 0 ]; then
		exit 1
	fi

	eval set -- "$temp"

	###########
	# OPTIONS #
	###########

	declare -gA CONFIG=(
		[config_only]=false     # -c, --config-only
		[shell]="bash"          # -s, --shell
		[shell_specified]=false # indicates if -s option has been specified
		[all_programs]=false    # -p, --all-programs
		[all_home_files]=false  # -d, --all-home-files
		[dry_run]=true          # -n, --no-dry
		[assume_yes]=false      # -y, --assume-yes
	)

	while true; do
		case "$1" in
		'-h' | '--help')
			print_usage
			;;
		'-l' | '--list')
			print_setup_list
			;;
		'-c' | '--config-only')
			CONFIG[config_only]=true
			shift
			;;
		'-s' | '--shell')
			CONFIG[shell_specified]=true
			CONFIG[shell]=$2
			shift 2
			;;
		'-P' | '--all-programs')
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

	if (($# >= 1)); then
		for prog in "$@"; do
			setup_prog=${programs[$prog]}
			if ! [[ "$setup_prog" ]]; then
				warn "Program '$prog' not found"
				continue
			fi
			run_setup "$setup_prog"
		done
		exit 0
	fi

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

# Run command if not in dry run else print it
# usage: run [command]
# or pipe command into it (heredoc for long commands with quotes)
run() {
	COMMAND=$*
	if [[ -z "$COMMAND" ]]; then
		while read -r line; do
			run "$line"
		done
	fi
	local line
	if ${CONFIG[dry_run]}; then
		info "[DRY_RUN]:" "$(printf '%b' "$COMMAND")"
	else
		debug "[RUNNING] ${ITALIC}$COMMAND"
		eval "$COMMAND" |&
			while read -r line; do
				debug "[RUNNING]\t$line"
			done
	fi
}

#TODO replace these two functions with a single install_pkg function
# which takes the name of the wanted binary and finds the package that provides it on
# the detected distro (i.e. rg -> ripgrep)

# Install one or more pacman packages
install_pacman() {
	[[ ! "$DISTRO_ID" = "arch" ]] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run sudo pacman -S --noconfirm --needed "$*"; then
		success "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Install one or more dnf packages
install_dnf() {
	[[ ! "$DISTRO_ID" = "fedora" ]] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run sudo dnf install -y "$*"; then
		success "Installed packages"
	else
		fatal "Failed to install packages"
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
	local setup_exit_code=0

	if ! ${CONFIG[config_only]}; then
		setup
		setup_exit_code=$?
	fi

	local config_exit_code=0
	if command -v config >/dev/null; then # check if function config exists
		config
		config_exit_code=$?
	fi

	# remove script's functions from scope
	unset setup config

	if [[ -f "$shell_script" ]]; then
		if [[ -n "$DOTFILES_RC_FILE" && -w "$DOTFILES_RC_FILE" ]]; then
			run <<-EOF
				echo "source \"$shell_script\"" >>"$DOTFILES_RC_FILE"
			EOF
		else
			warn "RC_FILE='$DOTFILES_RC_FILE' not a valid path or file not writable"
		fi
	fi

	[[ "$setup_exit_code" = 0 && $config_exit_code = 0 ]]
}

setup_programs() {
	ask "Install and/or setup programs?" || return

	info "Installing and/or setting up programs in ./setup"

	if [[ -f "$DOTFILES_RC_FILE" ]]; then
		run <<-EOF
			echo "### SETUP SCRIPT ###" >>"$DOTFILES_RC_FILE"
		EOF
	fi

	local setup_dir
	for setup_dir in ./setup/*/; do
		if run_setup "$setup_dir"; then
			success "Setup $setup_dir"
		else
			warn "Failed to setup $setup_dir"
		fi
		echo
	done

	success "Installed and/or setup programs in ./setup"

	echo
}

setup_home() {
	ask "Install ./home/.* in $HOME/?" || return

	info "Linking dot files to home"

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

	success "Linked dotfiles"

	echo
}

main() {
	parse_args "$@"

	[[ ! -d ~/.config ]] && run mkdir ~/.config
	[[ ! -d ~/.local/bin ]] && run mkdir -p ~/.local/bin
	setup_programs
	setup_home

	echo

	info "Run 'source $DOTFILES_RC_FILE' to apply configs!"
}

main "$@"
