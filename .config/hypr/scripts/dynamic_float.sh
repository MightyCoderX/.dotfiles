#!/bin/bash

handle() {
	local event=$1

	[[ $event =~ windowtitlev2* ]] || return

	local event_name data
	IFS=':' read -r event_name data <<<"${event/>>/:}"

	local window_address window_title
	IFS=',' read -r window_address window_title <<<"$data"

	echo "[$(date +'%T %F %N')]: $event_name: $window_address $window_title"
	if [[ "$window_title" =~ ^(Extension:)(.*)$ ]]; then
		hyprctl --batch dispatch setfloating "address:0x$window_address" \; dispatch centerwindow
	fi
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock |
	while read -r line; do handle "$line"; done
