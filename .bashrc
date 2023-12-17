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


# History
shopt -s histappend
export HISTCONTROL='ignoreboth'
export HISTSIZE=500000
export HISTFILESIZE=1000000
export HISTTIMEFORMAT='[%F %T] '

# Package suggestion on command not found
source /usr/share/doc/pkgfile/command-not-found.bash

shopt -s autocd # Enable autocd to change dir by just typing the path
set -o noclobber # Disable overriding files with redirection


# 
# Aliases
#

alias ls='ls --color=auto -v'
alias ll='ls -lA'
alias ip='ip --color=auto'


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


