HISTFILE="${XDG_STATE_HOME:-~/.local/state}/zsh/history"
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
