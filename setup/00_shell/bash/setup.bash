setup() {
	if ! cmd_exists bash; then
		install_pkg bash
	fi

	run mkdir -p ~/.local/state/bash
	if [[ -f ~/.bash_history ]]; then
		run mv ~/.bash_history ~/.local/state/bash/history
	fi
}
