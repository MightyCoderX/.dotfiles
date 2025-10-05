setup() {
	[[ ! -d ~/repo ]] && mkdir ~/repo

	REPO_PATH=~/repo/asmfetch

	[[ -d "$REPO_PATH" ]] && run rm -rf "$REPO_PATH"
	run git clone https://github.com/ErrorNoInternet/asmfetch "$REPO_PATH" || return 1

	# Build and Install

	run <<-EOF
		pushd "$REPO_PATH" || return 1
		make
		sudo make install
		popd || return 1
	EOF
}
