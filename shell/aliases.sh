# Aliases
# alias ls='ls --color=auto -v'
# alias ll='ls -lAh'
# alias tree='tree -C -I .git'
alias ip='ip --color=auto'
alias cd='z'
alias ls='eza -l --icons'
alias ll='ls -a'
alias tree='eza -l --icons --tree'

_alias_fman() {
    man -k . | tr -d '()' | awk '{ print $1 "." $2 }'| fzf --preview 'unset MANPAGER; man {}' | xargs man
}

alias fman='_alias_fman'

