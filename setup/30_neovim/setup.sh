setup() {
	install_pacman neovim
	install_dnf neovim

	run ln -s "$(which nvim)" "$HOME/.local/bin/vim"

	run mv ~/.config/nvim{,.bak}
	run git clone https://github.com/LazyVim/starter ~/.config/nvim
	run rm -rf ~/.config/nvim/.git
}

config() {
	[[ -z "$DOTFILES_PATH" ]] && fatal 'variable DOTFILES_PATH needs to be set!'

	run cp --backup --recursive "$DOTFILES_PATH"/.config/nvim/* ~/.config/nvim/
	run cp --backup --recursive "$DOTFILES_PATH"/.config/nvim/.* ~/.config/nvim/
}
