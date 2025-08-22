setup() {
	install_pacman alacritty
	install_dnf alacritty

}

config() {
	run ln -s "$DOTFILES_DIR"/.config/alacritty ~/.config/alacritty
}
