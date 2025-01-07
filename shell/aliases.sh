# Aliases
# alias ls='ls --color=auto -v'
# alias ll='ls -lAh'
# alias tree='tree -C -I .git'
alias ip='ip --color=auto'
alias cd='z'
alias ls='eza -lg --icons=auto'
alias ll='ls -a'
alias l.='ls .*'
alias tree='eza -lg --icons=auto --tree'
alias tz="tz -w -m"
alias grep="grep --color"
alias rm="trash"

_alias_fman() {
    man -k . | tr -d '()' | awk '{ print $1 "." $2 }'| fzf --preview 'unset MANPAGER; man {}' | xargs man
}

alias fman='_alias_fman'

