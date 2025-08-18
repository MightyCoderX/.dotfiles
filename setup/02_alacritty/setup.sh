setup() {
	install_pacman alacritty
	install_dnf alacritty

}

config() {
	ln -s "$DOTFILES_DIR"/.config/alacritty ~/.config/alacritty
}
