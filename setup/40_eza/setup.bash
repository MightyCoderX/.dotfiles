setup() {
	install_pkg 'eza' || return 1
	# install_pkg fedora DNF_PACKAGE_NAME # package not available on fedora
}
