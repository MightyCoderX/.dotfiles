#!/usr/bin/env bash

# hypr* required packages
paru --rebuild -S \
	hyprland-protocols-git \
	hyprwayland-scanner-git \
	hyprutils-git \
	hyprgraphics-git \
	hyprlang-git \
	hyprcursor-git \
	aquamarine-git \
	xdg-desktop-portal-hyprland-git \
	hyprwire-git \
	hyprtoolkit-git \
	hyprland-git

# hyprapps packages
paru --rebuild -S \
	hyprlock-git \
	hypridle-git \
	hyprpaper-git \
	hyprpicker-git \
	hyprsunset-git \
	hyprpolkitagent-git \
	hyprland-qt-support-git \
	hyprland-guiutils-git
