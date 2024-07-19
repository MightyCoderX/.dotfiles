#!/bin/bash

#TODO cp shell folder in .config/shell (?)

ask() {
    read -rp "$1 (Y/n): " resp

    [ -z "$resp" ] || [ "$resp" = "y" ]
}

echo -e "\nShell configuration (bash)\n"
for local_path in shell/*; do
    ! ask "Source $local_path?" && continue
    
    echo "source $(realpath "$local_path")" >> ~/.bashrc
done

echo -e "\nMisc configs \n"
configs=(
    '.vimrc'
    '.tmux.conf'
    '.gitconfig'
    '.config/alacritty'
    '.config/hypr'
)
for local_path in "${configs[@]}"; do
    ! ask "Install $local_path?" && continue

    ln -s "$(realpath "$local_path")" ~/"$local_path"
done
