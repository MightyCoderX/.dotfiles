# Readline Options
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'set revert-all-at-newline on'

# Keybinds
bind '"\e[Z":menu-complete' # Shift+TAB to scroll through completion options
bind -x '"\C-f":"tmux-sessionizer"'

# Disabling Control Flow (C-s and others) to allow i-search (C-s)
# https://unix.stackexchange.com/a/12146
stty -ixon
