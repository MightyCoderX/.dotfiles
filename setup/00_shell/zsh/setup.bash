setup() {
	install_pkg zsh
}

#TODO move zsh files into XDG_ directories

config() {
	run cp "$DOTFILES_PATH"/home/.zshrc ~/.zshrc
}
