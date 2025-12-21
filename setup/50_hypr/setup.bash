setup() {
	if ask "Use hypr*-git packages?"; then
		run ./scripts/rebuild_hypr_git.sh
		return
	fi

	install_pkg \
		hyprland-protocols \
		hyprwayland-scanner \
		hyprutils \
		hyprgraphics \
		hyprlang \
		hyprcursor \
		aquamarine \
		xdg-desktop-portal-hyprland \
		hyprwire \
		hyprtoolkit \
		hyprland

	install_pkg \
		hyprlock \
		hypridle \
		hyprpaper \
		hyprpicker \
		hyprsunset \
		hyprpolkitagent \
		hyprland-qt-support \
		hyprland-guiutils

	# if ~/.config/hypr is not a symlink back it up
	[[ -L $HOME/.config/hypr ]] || run cp "$HOME/.config/hypr" "$HOME/.config/hypr.bak"

	run ln -s "$(realpath ".config/hypr")" "$HOME/.config/hypr"
}

config() {
	:
}
