setup() {
	install_pacman git
	install_dnf git
}

config() {
	[[ -z "$DOTFILES_PATH" ]] && fatal 'variable DOTFILES_PATH needs to be set!'

	run cp -r "$DOTFILES_PATH"/.config/git ~/.config/git
}
