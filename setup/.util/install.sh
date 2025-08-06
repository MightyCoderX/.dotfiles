[ -n "$DOTFILES_UTIL_INSTALL" ] && return
DOTFILES_UTIL_INSTALL=1

source ./run.sh
source ./distro_info.sh

# Install one or more pacman packages
install_pacman() {
    [ ! "$DISTRO_ID" = "arch" ] && return
    run sudo pacman -S --noconfirm --needed "$*"
}

# Install one or more dnf packages
install_dnf() {
    [ ! "$DISTRO_ID" = "fedora" ] && return
    run sudo dnf install -y "$*"
}
