#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# Bash
#

# Prompt
export PROMPT_DIRTRIM=3

_clr()
{
    clr="\[\e[38;5;$1m\]"
    printf "${clr@P}"
}


UCLR="$(_clr 33)"
HCLR="$(_clr 38)"
ICLR="$(_clr 208)"
BCLR="$(_clr 220)"
RST="\[\e[0m\]"

_identity()
{
    id_display="$UCLR\u$RST@$HCLR\h$RST"
    printf "${id_display@P}"
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

PS1='[$(_identity) \w$(_branch)]\$ '

shopt -s autocd     # Enable autocd to change dir by just typing the path
set -o noclobber    # Disable overriding files with redirection

# History
shopt -s histappend
export HISTCONTROL='ignoreboth'
export HISTSIZE=500000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='[%F %T] '

# Readline Options
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-completion-prefix on'
bind 'set colored-stats on'
bind 'set visible-stats on'
bind 'TAB:menu-complete'
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
# List all readline keybinds
alias bindl="(printf 'COMMAND\tKEYBIND(s)' && bind -P | grep -v 'is not bound' | sed 's/can be found on //') | column -t"

export LESS='-R --mouse'



#
# SSH Agent
#

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${XDG_RUNTIME_DIR}ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "${XDG_RUNTIME_DIR}ssh-agent.env" >/dev/null
fi


. "$HOME/.cargo/env"
