local wezterm = require("wezterm")

local config = {}

config.default_prog = { "/usr/bin/fish" }

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
custom.background = "#11111b" -- crust

config.color_schemes = {
    ["Catppuccin Espresso"] = custom
}
config.color_scheme = "Catppuccin Espresso"

config.font = wezterm.font_with_fallback({
	"MesloLGS Nerd Font",
	"Font Awesome 6 Free Solid",
})
config.font_size = 12
config.bold_brightens_ansi_colors = false

config.enable_tab_bar = false

config.window_background_opacity = 1

-- config.text_background_opacity = 0

-- Fix accidental URL clicks
config.mouse_bindings = {
	-- Disable the default click behavior
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = wezterm.action.CompleteSelection("PrimarySelection"), -- You may want a different option here. See /u/Brian's comment below
	},
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the Ctrl-click down event to stop programs from seeing it when a URL is clicked
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.Nop,
	},
}

return config
