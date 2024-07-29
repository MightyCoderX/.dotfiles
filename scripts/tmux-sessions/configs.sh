#!/bin/sh -Eeu

session="configs"

if tmux list-sessions | grep -q "$session"; then
    printf 'session %s already exists!\n' "$session" >&2
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

    tmux new-session -d -c "$root_dir" -s "$session" "nvim $root_dir/.config/hypr/hyprland.conf"
    tmux rename-window -t "$session:$window_index" 'hyprland'

    _new_window 'waybar' "nvim $root_dir/.config/waybar/config.jsonc"
    _new_window 'nvim' "nvim $root_dir/.config/nvim/init.lua"
    _new_window 'tmux' "nvim $root_dir/.config/tmux/tmux.conf"
    _new_window 'swaync' "nvim $root_dir/.config/swaync/config.json"
    _new_window 'wezterm' "nvim $root_dir/.config/wezterm/wezterm.lua"
    _new_window 'bemenu' "nvim $root_dir/scripts/bemenu.sh"

    tmux attach-session -t "$session"
else
    printf 'session %s already exists!\n' "$session" >&2
fi

