#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PROMPT_DIRTRIM=3

_clr()
{
    clr="\[\e[38;5;$1m\]"
    printf "${clr@P}"
}


UCLR="$(_clr 33)"
HCLR="$(_clr 38)"
WCLR="$(_clr 12)"
ICLR="$(_clr 208)"
BCLR="$(_clr 220)"
RST="\[\e[0m\]"

_identity()
{
    id_display="$UCLR\u$RST@$HCLR\h$RST"
    printf "${id_display@P}"
}

_wdir()
{
    wd_display="$WCLR\w$RST"
    printf "${wd_display@P}"
}

_branch()
{
    in_repo="$(git rev-parse --is-inside-work-tree 2> /dev/null)"
    branch_name="$(git branch --show-current 2> /dev/null)"
    commit_name="$(git rev-parse --short HEAD 2> /dev/null)"
    node_name="${branch_name:-$commit_name}"
    branch_display=" on $ICLR󰘬 $BCLR$node_name$RST"
    [[ $in_repo ]] && printf "${branch_display@P}" 
}

PS1='[$(_identity) $(_wdir)$(_branch)]\$ '

shopt -s autocd     # Enable autocd to change dir by just typing the path
set -o noclobber    # Disable overriding files with redirection

# History
shopt -s histappend
HISTCONTROL='ignoreboth'
HISTSIZE=-1
HISTFILESIZE=-1
HISTTIMEFORMAT='[%F %T] '
HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND" # Append history to HISTFILE before each command

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

# Package suggestion on command not found
PKGFILE_CNF_PATH="/usr/share/doc/pkgfile/command-not-found.bash"
[[ -e $PKGFILE_CNF_PATH ]] && source $PKGFILE_CNF_PATH

# Aliases
alias ls='ls --color=auto -v'
alias ll='ls -lAh'
alias tree='tree -C'
alias ip='ip --color=auto'

LESS='-R --mouse'
TERM='xterm-256color'


# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${XDG_RUNTIME_DIR}ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "${XDG_RUNTIME_DIR}ssh-agent.env" >/dev/null
fi


. "$HOME/.cargo/env"

