setup() {
	# Install distro packages if needed (not needed for something like bash)
	install_pacman PACMAN_PACKAGE_NAME
	install_dnf DNF_PACKAGE_NAME

	# Do other stuff like cloning repos for scripts
	# run rm -rf "$HOME/repo/REPO_NAME"
	# run git clone https://github.com/NAMESPACE/REPO_NAME.git "$HOME/repo/REPO_NAME"
	# run cp "$HOME/repo/REPO_NAME/SCRIPT_EXECUTABLE" "$HOME/.local/bin/"
}

config() {
	# Use this function to run commands that are used to update copied config files
	# so you don't have to reinstall just to update the config, thus you don't need this
	# function if you just symlink the whole config directory to ~/.config

	[[ -z "$DOTFILES_PATH" ]] && fatal 'variable DOTFILES_PATH needs to be set!'

	# Copy config into ~/.config
	# run cp -r "$DOTFILES_PATH"/.config/PROGRAM ~/.config/PROGRAM
}
