setup() {
	install_pkg tmux

	run rm -rf "$HOME/repo/tmux-sessionizer"
	run git clone https://github.com/ThePrimeagen/tmux-sessionizer.git "$HOME/repo/tmux-sessionizer"
	[[ ! -d "$HOME/.local/bin" ]] && run mkdir -p "$HOME/.local/bin"
	run cp "$HOME/repo/tmux-sessionizer/tmux-sessionizer" "$HOME/.local/bin/"
}
