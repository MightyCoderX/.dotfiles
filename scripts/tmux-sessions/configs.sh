#!/bin/sh

tmux new-session -c ~/.dotfiles -s configuration 'nvim .config/hypr/hyprland.conf'\;\
	rename-window 'hyprland' \;\
	new-window 'nvim ~/.dotfiles/.config/waybar/config.jsonc' \;\
	rename-window 'waybar' \;\
	split-window -h 'nvim ~/.dotfiles/.config/waybar/style.css' \;\
	split-window -v \;\
	new-window 'nvim ~/.dotfiles/.config/nvim/init.lua' \;\
	rename-window 'nvim' \;\
	new-window 'nvim ~/.dotfiles/.config/tmux/tmux.conf' \;\
	rename-window 'tmux' \;\
	new-window 'nvim ~/.dotfiles/.config/swaync/config.json' \;\
	rename-window 'swaync' \;\
	new-window 'nvim ~/.dotfiles/.config/alacritty/alacritty.toml' \;\
	rename-window 'alacritty' \;\
	attach-session

