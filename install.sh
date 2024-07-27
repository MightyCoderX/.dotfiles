#!/bin/bash -Eeu

ask() {
    read -rp "$1 (Y/n): " resp

    [ -z "$resp" ] || [ "$resp" = "y" ]
}

rc_file=""

case "$(basename "$SHELL")" in
    bash)
        rc_file+="$HOME/.bashrc"
        ;;
    zsh)
        rc_file+="$HOME/.zshrc"
        ;;
    *)
        echo "Detected unknown shell '$SHELL'"
        ;;
esac

while [ ! -w "$rc_file" ]; do
    echo "rc file does not exist or is not writeable"
    read -rp "rc file path: \n" rc_file_name
    rc_file+="$rc_file_name"
done

echo -e "\nShell configs (shell dependent)\n"
for local_path in shell/*.{"$(basename "$SHELL")",sh}; do
    ! ask "Source $local_path?" && continue
    
    echo "source $(realpath "$local_path")" >> "$rc_file"
done

echo -e "\nMisc configs \n"
for local_path in $(find .config home -mindepth 1 -maxdepth 1); do
    if [ "$(dirname "$local_path")" = "home" ]; then
        local_path="$(basename "$local_path")"
    fi

    ! ask "Install $local_path?" && continue

    ln -s "$(realpath "$local_path")" "$HOME/$local_path"
done

