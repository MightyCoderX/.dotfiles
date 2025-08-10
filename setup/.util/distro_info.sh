[ -n "$DOTFILES_UTIL_DISTRO_INFO" ] && return
DOTFILES_UTIL_DISTRO_INFO=1

while read -r; do
	export DISTRO_"$REPLY"
done </etc/os-release
