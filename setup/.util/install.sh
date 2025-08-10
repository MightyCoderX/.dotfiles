[ -n "$DOTFILES_UTIL_INSTALL" ] && return
DOTFILES_UTIL_INSTALL=1

builtin source "$(dirname "${BASH_SOURCE[0]}")"/run.sh
builtin source "$(dirname "${BASH_SOURCE[0]}")"/distro_info.sh

# Install one or more pacman packages
install_pacman() {
	[ ! "$DISTRO_ID" = "arch" ] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run "sudo pacman -S --noconfirm --needed $* >/dev/null"; then
		info "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}

# Install one or more dnf packages
install_dnf() {
	[ ! "$DISTRO_ID" = "fedora" ] && return
	info "Installing $DISTRO_PRETTY_NAME packages: $*"
	if run "sudo dnf install -y $* >/dev/null"; then
		info "Installed packages"
	else
		fatal "Failed to install packages"
	fi
}
