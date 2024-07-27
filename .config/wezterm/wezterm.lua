local wezterm = require("wezterm")

local config = {}

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
custom.background = "#11111b" -- crust

config.color_schemes = {
    ["Catppuccin Espresso"] = custom
}
config.color_scheme = "Catppuccin Espresso"

config.font = wezterm.font_with_fallback({
    "MesloLGS Nerd Font",
})
config.font_size = 12
config.bold_brightens_ansi_colors = false

config.enable_tab_bar = false

config.window_background_opacity = 0.9

-- config.text_background_opacity = 0

return config

