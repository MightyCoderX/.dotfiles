#!/bin/sh
set -eu

action="$1"
target="$2"

screenshots_dir="$HOME/Pictures/Screenshots"
file_name="$(date +'%Y%m%d_%H%M%S_grim.png')"
file_path="$screenshots_dir/$file_name"

grimblast --notify "$action" "$target" "$file_path"

# notify-send --transient\
#     -i "$file_path"\
#     -a "System"\
#     --action 'default=Open Screenshot'\
#     "Screeshot"\
#     "Saved screenshot $file_name"\

