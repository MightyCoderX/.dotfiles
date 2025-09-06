setup() {
	install_pacman neovim
	install_dnf neovim

	run ln -s "$(command -v nvim)" "$HOME/.local/bin/vim"

	run mv ~/.config/nvim{,.bak}
	run git clone https://github.com/LazyVim/starter ~/.config/nvim
	run rm -rf ~/.config/nvim/.git
}

config() {
	[[ -z "$DOTFILES_PATH" ]] && fatal 'variable DOTFILES_PATH needs to be set!'

	run cp -R ~/.config/nvim ~/.config/nvim.old
	run cp -R "$DOTFILES_PATH"/.config/nvim/* ~/.config/nvim/
	run cp -R "$DOTFILES_PATH"/.config/nvim/.* ~/.config/nvim/
}
