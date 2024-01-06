#!/bin/bash

# Readline Options
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'set revert-all-at-newline on'
bind '"\e[Z":menu-complete' # Shift+TAB to scroll through completion options
# List all readline keybinds
alias bindl="(printf 'COMMAND\tKEYBIND(s)' && bind -P | grep -v 'is not bound' | sed 's/can be found on //') | column -t -l 2"
# Disabling Control Flow (C-s and others) to allow i-search (C-s)
# https://unix.stackexchange.com/a/12146
stty -ixon
