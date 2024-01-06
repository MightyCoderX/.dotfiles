#!/bin/bash

#TODO cp shell folder in .config/shell (?)

ask() {
    read -rp "$1 (Y/n): " resp

    [ -z "$resp" ] || [ "$resp" = "y" ]
}

echo -e "\nShell configuration (bash)\n"
for file in shell/*; do
    ! ask "Source $file?" && continue
    
    echo "source $(realpath "$file")" >> ~/.bashrc
done

echo -e "\nMisc configs \n"
configs=('.vimrc' '.tmux.conf' '.gitconfig' '.config/alacritty/alacritty.yml')
for file in "${configs[@]}"; do
    ! ask "Install $file?" && continue

    ln -s "$(realpath "$file")" ~/"$file"
done
