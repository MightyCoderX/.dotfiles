setup_shell_configs() {
	ask "Source shell configurations in respective rc files?" || return

	info "Sourcing /home/.env"
	echo "source $DOTFILES_PATH/home/.env" >>~/.bashrc

	info "Sourcing shell configurations"

	[[ ! -d ./shell ]] && warn "Directory ./shell not found, skipping" && return

	for shell_conf in ./shell/*.{sh,bash}; do
		echo "source $(realpath "$shell_conf")" >>~/.bashrc
	done

	success "Sourced all shell configurations"

	echo
}

setup() {
	DOTFILES_SHELL=""
	[[ "${CONFIG[shell]}" = "bash" ]] && while [[ -z "$DOTFILES_SHELL" ]]; do
		read -rp "Select shell (bash/zsh) (default: ${CONFIG[shell]}): "
		[[ -z "$REPLY" ]] && REPLY=${CONFIG[shell]}
		case "$REPLY" in
		bash | zsh)
			DOTFILES_SHELL="$REPLY"
			;;
		esac
	done

	case "$DOTFILES_SHELL" in
	bash)
		DOTFILES_RC_FILE=~/.bashrc
		;;
	zsh)
		DOTFILES_RC_FILE=~/.zshrc
		;;
	esac

	if [[ ! "$DOTFILES_RC_FILE" ]]; then
		fatal "rc file path needed to run setup scripts"
	fi

	if [[ ! -w "$DOTFILES_RC_FILE" ]]; then
		fatal "rc file '$DOTFILES_RC_FILE' doesn't exist or is not writeable"
	fi

	run_setup "$SCRIPT_DIR"/"$DOTFILES_SHELL"

	setup_shell_configs
	unset -f setup_shell_configs
}
