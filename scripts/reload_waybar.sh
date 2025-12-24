#!/bin/sh

if pidof waybar; then
	kill -s USR2 "$(pidof waybar)"
else
	hyprctl dispatch exec waybar
fi
