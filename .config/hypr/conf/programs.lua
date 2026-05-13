-- conf/programs.lua
-- Define program variables globally so other modules (binds, autostart) can use them.

_G.terminal    = "wezterm"
_G.browser     = "zen-browser"
_G.fileManager = "nautilus"
_G.menu        = "rofi -show drun"
_G.editor      = "nvim"

hl.env("BROWSER",          browser)
hl.env("TERMINAL",         terminal)
hl.env("EDITOR",           editor)
hl.env("FILEMANAGER",      fileManager)
hl.env("XDG_UTILS_TERMINAL",    terminal)
hl.env("XDG_UTILS_BROWSER",     browser)
hl.env("XDG_UTILS_FILEMANAGER", fileManager)
