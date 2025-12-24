#!/bin/sh -Eeu

session="dotfiles"

if tmux list-sessions | grep -q "$session"; then
    tmux attach-session -t "$session"
    exit 1
fi

_new_window() {
    window_name="$1"
    command="$2"

    window_index=$(( window_index + 1 ))
    tmux new-window -t "$session:$window_index" -n "$window_name" "$command"

    unset window_name command
}

if ! tmux list-sessions | grep -q "$session"; then
    root_dir="$HOME/.dotfiles"
    window_index=1

    tmux new-session -d -c "$root_dir" -s "$session" "cd $root_dir/.config; nvim . +'Telescope find_files'"
    tmux rename-window -t "$session:$window_index" '.config'

    _new_window 'hypr*' "cd $root_dir/.config/hypr; nvim . +'Telescope find_files'"
    _new_window 'waybar' "cd $root_dir/.config/waybar/; nvim config.jsonc"
    _new_window 'swaync' "cd $root_dir/.config/swaync/; nvim config.json"
    _new_window 'rofi' "cd $root_dir/.config/rofi/; nvim config.rasi"

    _new_window 'wezterm' "cd $root_dir/.config/wezterm; nvim wezterm.lua"
    _new_window 'tmux' "cd $root_dir/.config/tmux; nvim tmux.conf"
    _new_window 'shell' "cd $root_dir/shell; nvim . +'Telescope find_files'"
    _new_window 'fish' "cd $root_dir/.config/fish; nvim . +'Telescope find_files'"
    _new_window 'nvim' "cd $root_dir/.config/nvim; nvim . +'Telescope find_files'"

    _new_window 'scripts' "cd $root_dir/scripts; nvim . +'Telescope find_files'"

    _new_window 'lazygit' "lazygit"

    tmux attach-session -t "$session"
fi

