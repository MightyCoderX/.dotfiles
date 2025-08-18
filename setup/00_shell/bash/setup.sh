setup() {
	run mkdir -p ~/.local/state/bash
	[[ -f ~/.bash_history ]] && run mv ~/.bash_history ~/.local/state/bash/history
}
