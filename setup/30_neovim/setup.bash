setup() {
	install_pkg neovim || return 1

	run ln -s "$(command -v nvim)" "$HOME/.local/bin/vim"

	[[ -f ~/.config/nvim ]] && run mv ~/.config/nvim{,.bak}
	run git clone https://github.com/LazyVim/starter ~/.config/nvim
	run rm -rf ~/.config/nvim/.git
}

config() {
	[[ -z "$DOTFILES_PATH" ]] && fatal 'variable DOTFILES_PATH needs to be set!'

	run cp -R ~/.config/nvim ~/.config/nvim.old
	for file in "$DOTFILES_PATH"/.config/nvim/.* "$DOTFILES_PATH"/*; do
		run cp -R "$file" ~/.config/nvim/
	done
}
