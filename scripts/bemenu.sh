#!/bin/sh

# Catpuccin Mocha
if pidof bemenu-run; then
    killall bemenu-run
else
    bemenu-run\
        -l 5 --fixed-height -c -W 0.5 --fn "Hack Nerd Font 12"\
        -p run --single-instance\
        --fn "monospace 12" -H 30\
        --fb "#1e1e2e"\
        --ff "#cdd6f4"\
        --nb "#1e1e2e"\
        --nf "#cdd6f4"\
        --tb "#1e1e2e"\
        --hb "#1e1e2e"\
        --tf "#f38ba8"\
        --hf "#f9e2af"\
        --af "#cdd6f4"\
        --ab "#1e1e2e"
fi

