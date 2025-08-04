#!/bin/bash -Eeu

ask() {
    read -rp "$1 (Y/n): " resp

    [ -z "$resp" ] || [ "$resp" = "y" ]
}

envsubst

case "$(basename "$SHELL")" in
    bash)
        install_bash
        ;;
    zsh)
        install_zsh
        ;;
    *)
        echo "Detected unknown shell '$SHELL'"
        ;;
esac

install_bash() {
    mv .bashrc
}

install_zsh() {
    :
}

echo -e "\nShell extras (based on $$SHELL)\n"
for local_path in shell/*.{"$(basename "$SHELL")",sh}; do
    ! ask "Source $local_path?" && continue

    echo "source $(realpath "$local_path")" >> "$rc_file"
done

echo -e "\nMisc configs\n"
find .config home -mindepth 1 -maxdepth 1 | while read -r local_path; do
    if [ "$(dirname "$local_path")" = "home" ]; then
        local_path="$(basename "$local_path")"
    fi

    ! ask "Install $local_path?" && continue

    ln -s "$(realpath "$local_path")" "$HOME/$local_path"
done

