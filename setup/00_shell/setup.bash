DOTFILES_SHELL=""
while [[ -z "$DOTFILES_SHELL" ]]; do
	read -rp "Select shell (bash/zsh): "
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

run_setup "$SCRIPT_DIR"/"$DOTFILES_SHELL"

if [[ ! -w "$DOTFILES_RC_FILE" ]]; then
	fatal "rc file '$DOTFILES_RC_FILE' doesn't exist or is not writeable"
fi
