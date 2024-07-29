#!/bin/sh -Eeu

waydroid_apps="$HOME/.local/share/applications/waydroid.*.desktop"

sed --in-place --separate '/Actions=app_settings/a NoDisplay=true' $waydroid_apps

