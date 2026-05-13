-- conf/autostart.lua

hl.on("hyprland.start", function()
    -- XDG / dbus
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- GTK settings
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-im-module "fcitx"')
    hl.exec_cmd("gsettings set org.gnome.settings-daemon.plugins.xsettings overrides \"{'Gtk/IMModule':<'fcitx'>}\"")
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"')
    hl.exec_cmd('gsettings set org.gnome.desktop.interface cursor-size 24')
    hl.exec_cmd('hyprctl setcursor Adwaita 24')

    -- Nautilus open-any-terminal
    hl.exec_cmd('gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal ' .. terminal)
    hl.exec_cmd("gsettings set com.github.stunkymonkey.nautilus-open-any-terminal keybindings '<Ctrl><Alt>t'")
    hl.exec_cmd('gsettings set com.github.stunkymonkey.nautilus-open-any-terminal new-tab false')
    hl.exec_cmd('gsettings set com.github.stunkymonkey.nautilus-open-any-terminal flatpak system')

    -- Switch to workspace 1 on start
    hl.dispatch(hl.dsp.focus({ workspace = "1" }))

    -- Polkit agent
    hl.exec_cmd("systemctl --user start hyprpolkitagent")

    -- Automount
    hl.exec_cmd("udiskie")

    -- Idle / lock
    hl.exec_cmd("hypridle")

    -- Wallpaper
    hl.exec_cmd("hyprpaper")

    -- Clipboard
    hl.exec_cmd("wl-clip-persist --clipboard both")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Status bar & notifications
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")

    -- Input method
    hl.exec_cmd("fcitx5")

    -- XWayland: set HDMI-A-1 as primary
    hl.exec_cmd("xrandr --output HDMI-A-1 --primary")

    -- Keyboard layout (XWayland)
    hl.exec_cmd("setxkbmap it")

    -- Tray / apps
    hl.exec_cmd("kdeconnect-indicator")
    hl.exec_cmd("nextcloud")
end)
