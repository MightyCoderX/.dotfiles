# Aliases
# alias ls='ls --color=auto -v'
# alias ll='ls -lAh'
# alias tree='tree -C -I .git'
alias ip='ip --color=auto'
alias ls='eza -lg --icons=auto'
alias ll='ls -a'
alias l.='ls .*'
alias tree='eza -lg --icons=auto --tree'
alias tz="tz -w -m"
alias grep="grep --color"
alias rm="trash"

_alias_fman() {
    man -k . | tr -d '()' | awk '{ print $1 "." $2 }' | fzf --preview 'unset MANPAGER; man {}' | xargs man
}

alias fman='_alias_fman'
alias adb='HOME="$XDG_DATA_HOME"/android adb'

# List all readline keybinds
alias bindl="(printf 'COMMAND\tKEYBIND(s)' && bind -P | grep -v 'is not bound' | sed 's/can be found on //') | column -t -l 2"
