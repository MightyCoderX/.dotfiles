#!/bin/sh

option="${1:-FULL_SCREEN}"

screenshots_dir="$HOME/Pictures/Screenshots"
file_name="$(date +'%Y%m%d_%H%M%S_grim.png')"
file_path="$screenshots_dir/$file_name"

case "$option" in
    SELECT_AREA)
        selection="$(slurp -d)" || exit "$?"
        grim -g "$selection" - | tee "$file_path" | wl-copy -f
        ;;

    FULL_SCREEN)
        grim -c - | tee "$file_path" | wl-copy -f
        ;;
    *)
        exit 1
        ;;
esac

notify-send\
    -i "/usr/share/icons/HighContrast/48x48/mimetypes/image-x-generic.png"\
    -a "System"\
    --action 'default=Open Screenshot'\
    "Screeshot"\
    "Saved screenshot $file_name <img src='$(realpath $file_path)'>"\

