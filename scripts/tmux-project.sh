#!/bin/sh

projects_root="$HOME/dev"

dir_path="$(find "$projects_root" -type d 2>/dev/null | fzf)"
dir_name="$(basename "$dir_path")"

if ! tmux has-session -t "$dir_name"; then
    tmux new -d -c "$dir_path" -s "$dir_name" "nvim +'Telescope find_files'"
    tmux split-window -h -t "$dir_name:1"
    tmux select-pane -t "$dir_name:1.1"
fi

if [ -n "$TMUX" ]; then
    tmux switch-client -t "$dir_name"
else
    tmux attach -t "$dir_name"
fi
