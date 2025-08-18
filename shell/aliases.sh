# Aliases
alias ls='ls --color=auto -v'
alias ll='ls -lAh'
alias tree='tree -C -I .git'
alias ip='ip --color=auto'
alias grep="grep --color"

# Search man with fzf
_alias_fman() {
	man -k . | tr -d '()' | awk '{ print $1 "." $2 }' | fzf --preview 'unset MANPAGER; man {}' | xargs man
}
alias fman='_alias_fman'

# List all readline keybinds
_alias_bindl() {
	{ printf 'COMMAND\tKEYBIND(s)' && bind -P | grep -v 'is not bound' | sed 's/can be found on //'; } |
		column -t -l 2
}
alias bindl='_alias_bindl'
