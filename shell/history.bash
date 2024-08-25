# History
shopt -s histappend
HISTCONTROL='ignoreboth'
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='[%F %T] '
HISTFILE="$XDG_STATE_HOME"/bash/history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # Append history to HISTFILE before each command

