setup() {
	[[ ! -d ~/repo ]] && mkdir ~/repo

	REPO_PATH=~/repo/asmfetch

	[[ -d "$REPO_PATH" ]] && run rm -rf "$REPO_PATH"
	run git clone https://github.com/ErrorNoInternet/asmfetch "$REPO_PATH"

	# Build and Install
	pushd "$REPO_PATH" || exit 1

	run <<-EOF
		sed -i -E 's|(\.include "logo/).*(\.S")|\1'"$DISTRO_ID"'\2|' asmfetch.S
	EOF

	run gcc -nostdlib -no-pie asmfetch.S -o asmfetch
	run cp asmfetch "$HOME/.local/bin/"
	popd || exit 1
}
