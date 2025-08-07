# Prompt
PROMPT_DIRTRIM=3

_clr() {
    clr="\[\e[38;5;$1m\]"
    printf "${clr@P}"
}

UCLR="$(_clr 34)"  # [U]sername color
HCLR="$(_clr 38)"  # [H]ostname color
WCLR="$(_clr 12)"  # [W]orkdir color
ICLR="$(_clr 208)" # branch [I]con color
BCLR="$(_clr 220)" # [B]ranch name color
RST="\[\e[0m\]"    # reset colors and formatting

_identity() {
    id_display="$UCLR\u$RST@$HCLR\h$RST"
    printf "${id_display@P}"
}

_wdir() {
    wd_display="$WCLR\w$RST"
    printf "${wd_display@P}"
}

_branch() {
    in_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    [[ ! $in_repo ]] && return

    branch_name="$(git branch --show-current 2>/dev/null)"
    commit_name="$(git rev-parse --short HEAD 2>/dev/null)"
    node_name="${branch_name:-$commit_name}"
    branch_display=" on $ICLR󰘬 $BCLR$node_name$RST"
    printf "${branch_display@P}"
}

PS1='[$(_identity) $(_wdir)$(_branch)]\$ '
