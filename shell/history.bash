# History
shopt -s histappend
HISTCONTROL='ignoreboth'
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='[%F %T] '
HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # Append history to HISTFILE before each command
