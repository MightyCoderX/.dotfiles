-- conf/environment.lua

local home = os.getenv("HOME")

hl.env("XCURSOR_SIZE",  "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XDG_CURRENT_SESSION",   "Hyprland")
hl.env("XDG_SESSION_TYPE",      "wayland")
hl.env("XDG_SESSION_DESKTOP",   "Hyprland")
hl.env("XDG_SCREENSHOTS_DIR",   home .. "/Pictures/Screenshots")
hl.env("EDITOR",                "vim")
hl.env("XDG_CACHE_HOME",        home .. "/.cache")
hl.env("XDG_CONFIG_HOME",       home .. "/.config")
hl.env("XDG_DATA_HOME",         home .. "/.local/share")
hl.env("XDG_STATE_HOME",        home .. "/.local/state")

hl.env("QT_QPA_PLATFORM",                  "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",      "1")
hl.env("QT_QPA_PLATFORMTHEME",             "Adwaita-Dark")
hl.env("QT_STYLE_OVERRIDE",                "Adwaita-Dark")

hl.env("GTK_THEME", "Adwaita-dark")

hl.env("MOZ_ENABLE_WAYLAND",    "1")
hl.env("GDK_SCALE",             "1")
hl.env("SDL_VIDEODRIVER",       "wayland")

hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS",   "@im=fcitx")

hl.env("ELECTRON_ENABLE_WAYLAND",      "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
