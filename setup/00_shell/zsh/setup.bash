setup() {
	install_pacman zsh
	install_dnf zsh
}

#TODO move zsh files into XDG_ directories

config() {
	cp "$DOTFILES_PATH"/home/.zshrc ~/.zshrc
}
