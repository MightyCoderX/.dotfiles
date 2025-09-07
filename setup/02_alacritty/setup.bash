setup() {
	install_pkg alacritty
}

config() {
	run ln -s "$DOTFILES_DIR"/.config/alacritty ~/.config/alacritty
}
