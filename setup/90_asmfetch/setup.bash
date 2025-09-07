setup() {
	[[ ! -d ~/repo ]] && mkdir ~/repo

	REPO_PATH=~/repo/asmfetch

	[[ -d "$REPO_PATH" ]] && run rm -rf "$REPO_PATH"
	run git clone https://github.com/ErrorNoInternet/asmfetch "$REPO_PATH" || return 1

	# Build and Install

	run <<-EOF
		pushd "$REPO_PATH" || return 1
		sed -i -E 's|(\.include "logo/).*(\.S")|\1'"$DISTRO_ID"'\2|' asmfetch.S
		gcc -nostdlib -no-pie asmfetch.S -o asmfetch
		cp asmfetch "$HOME/.local/bin/"
		popd || return 1
	EOF
}
