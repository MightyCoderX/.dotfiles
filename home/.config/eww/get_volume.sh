#!/bin/sh

device=$1

wpctl get-volume "$device" | sed -E 's/Volume: ([0-9.]+).*/\1/'
