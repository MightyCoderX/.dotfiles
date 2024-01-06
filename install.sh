#!/bin/bash

for file in shell/*; do
    fullpath="$(realpath "$file")"

    read -r -n1 -p "Source $file? (Y/n): " resp
    echo

    [ -z "$resp" ] || [ "$resp" = "y" ] && echo "source $fullpath" >> ~/.bashrc
done
