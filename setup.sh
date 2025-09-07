#!/usr/bin/env bash

# Enable nullglob to get an empty string if glob doesn't match
shopt -s nullglob

##############
#  Globals   #
##############
declare -A CONFIG=(
	[config_only]=false     # -c, --config-only
	[shell]="bash"          # -s, --shell
	[shell_specified]=false # indicates if -s option has been specified
	[all_programs]=false    # -P, --all-programs
	[all_home_files]=false  # -d, --all-home-files
	[dry_run]=true          # -n, --no-dry
	[assume_yes]=false      # -y, --assume-yes
)
PROGRAM_KEYS=()
declare -A PROGRAMS

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

	[[ "$resp" == "y" || ! -t 1 ]]
}

print_usage() {
	cat <<-EOF
		usage: $0 [OPTIONS] [PROGRAM]

		Options:
		   -h    prints this message
		   -l    list all programs to setup and/or config
		   -c    only run config function of setup scripts
		   -s    select shell to configure for interactive use (default bash)
		   -P    install and/or setup all programs without asking for each one
		   -d    symlink all home/.* files to $HOME/
		   -n    disables dry run
		   -y    automatically selects yes when a y/n prompt should show

	EOF
	exit 0
}

print_setup_list() {
	local setup_prog prog_name
	printf "%s\n" "${PROGRAM_KEYS[@]}"
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
	declare -gA CONFIG

	local OPTIND OPTION OPTARG
	while getopts 'hlcs:Pdny' OPTION; do
		case "$OPTION" in
		'h')
			print_usage
			;;
		'l')
			print_setup_list
			;;
		'c')
			CONFIG[config_only]=true
			;;
		's')
			CONFIG[shell_specified]=true
			CONFIG[shell]=$OPTARG
			;;
		'P')
			CONFIG[all_programs]=true
			;;
		'd')
			CONFIG[all_home_files]=true
			;;
		'n')
			CONFIG[dry_run]=false
			;;
		'y')
			CONFIG[assume_yes]=true
			;;
		*)
			print_usage
			;;
		esac
	done

	shift $((OPTIND - 1))

	if (($# >= 1)); then
		for prog in "$@"; do
			setup_prog=${PROGRAMS[$prog]}
			if ! [[ "$setup_prog" ]]; then
				warn "Program '$prog' not found"
				continue
			fi
			run_setup "$setup_prog"
		done
		exit 0
	fi

	info "Current config"
	for OPTION in "${!CONFIG[@]}"; do
		info "\t $OPTION = ${CONFIG[$OPTION]}"
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

# Check if command exists
cmd_exists() {
	local cmd=$1
	command -v "$cmd" >/dev/null
}

# Run command if not in dry run else print it
# usage: run <command>
#        run <<EOF
#           commands..
#        EOF
# or pipe command into it (heredoc for long commands with quotes)
run() {
	COMMAND=$*
	local line
	if [[ -z "$COMMAND" ]]; then
		nl=$'\n'
		cmd=''
		while IFS= read -r line; do
			cmd+="$line$nl"
		done
		run "$cmd"
		return $?
	fi
	if ${CONFIG[dry_run]}; then
		while IFS= read -r line; do
			info "[DRY_RUN]: $line"
		done <<<"${COMMAND%$'\n'}"
	else
		while IFS= read -r line; do
			debug "[RUNNING] ${ITALIC}$line"
		done <<<"${COMMAND%$'\n'}"
		set -o pipefail
		eval "$COMMAND" |&
			while read -r line; do
				debug "[OUTPUT] $line"
			done
		local cmd_err=$?
		set +o pipefail

		return $cmd_err
	fi
}

# Install packages for specified OS
# usage: install_pkg [-o os_name] <package...>
install_pkg() {
	local os_name
	local OPTIND OPTARG
	while getopts 'o:' OPTION; do
		case "$OPTION" in
		o)
			os_name=$OPTARG
			;;
		*)
			fatal "usage: install_pkg [-o os_name] <package...>"
			;;
		esac
	done

	shift $((OPTIND - 1))

	local packages=("$@")

	local sudo_commands=('doas' 'sudo' 'pfexec')
	local sudo_cmd=sudo

	for cmd in "${sudo_commands[@]}"; do
		if cmd_exists "$cmd"; then
			sudo_cmd=$cmd
			break
		fi
	done

	if [[ $os_name && $os_name != "$DISTRO_ID" ]]; then
		return 0
	fi

	os_name=${os_name:-$DISTRO_ID}
	local command args
	case "$os_name" in
	'arch')
		command='pacman'
		args='-S --noconfirm --needed'
		;;
	'fedora')
		command='dnf'
		args='install --assumeyes'
		;;
	'debian' | *ubuntu*)
		command='apt'
		args='install -y'
		;;
	'freebsd')
		command='pkg'
		args='install --yes'
		;;
	'sunos')
		command='pkg'
		command='install'
		;;
	*)
		fatal "unsupported OS '$os_name'"
		;;
	esac

	info "Installing $os_name packages:" "${packages[@]}"

	local command_line="$sudo_cmd $command $args"
	if run "$command_line" "${packages[@]}"; then
		success "Installed packages"
	else
		warn "Error while installing packages"
		return 1
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

	info "Running setup for $setup_dir"

	# shellcheck disable=2034 # used in sourced file
	SCRIPT_DIR=$setup_dir

	# shellcheck source=./setup/.template/setup.bash
	source "$setup_script"
	local setup_exit_code=0

	if ! ${CONFIG[config_only]}; then
		setup
		setup_exit_code=$?
	fi

	if ((setup_exit_code != 0)); then
		warn "Failed to run setup() for $setup_dir"
		return 1
	fi

	local config_exit_code=0
	if cmd_exists config; then # check if function config exists
		config
		config_exit_code=$?
	fi

	# remove script's functions from scope
	unset setup config

	if [[ -f "$shell_script" ]]; then
		if [[ -n "$DOTFILES_RC_FILE" && -w "$DOTFILES_RC_FILE" ]]; then
			run <<-EOF
				echo "source $shell_script" >>"$DOTFILES_RC_FILE"
			EOF
		else
			warn "RC_FILE='$DOTFILES_RC_FILE' not a valid path or file not writable"
		fi
	fi

	((setup_exit_code == 0 && config_exit_code == 0))
}

setup_programs() {
	ask "Install and/or setup programs?" || return

	info "Installing and/or setting up programs in ./setup"

	if [[ -f "$DOTFILES_RC_FILE" ]]; then
		run <<-EOF
			echo "### SETUP SCRIPT ###" >>"$DOTFILES_RC_FILE"
		EOF
	fi

	local prog_name
	for prog_name in "${PROGRAM_KEYS[@]}"; do
		local setup_dir=${PROGRAMS[$prog_name]}
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
	local setup_prog prog_name
	for setup_prog in ./setup/*/setup.bash; do
		setup_prog=${setup_prog%/**} # removes /setup.sh from end of path (dirname equivalent)
		prog_name=${setup_prog##**/} # remove all folders except last (basename equivalent)
		prog_name=${prog_name#**_}
		PROGRAM_KEYS+=("$prog_name")
		PROGRAMS[$prog_name]=$setup_prog
	done
	unset setup_prog prog_name

	[[ ! -d ~/.config ]] && run mkdir ~/.config
	[[ ! -d ~/.local/bin ]] && run mkdir -p ~/.local/bin

	install_pkg -o arch pkgfile

	setup_programs
	setup_home

	echo

	info "Run 'source $DOTFILES_RC_FILE' to apply configs!"
}

# run only if sourced (return fails if used in main file)
parse_args "$@"
(return 0 2>/dev/null) || main
