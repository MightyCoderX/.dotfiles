local wezterm = require("wezterm")

local config = {}

config.default_prog = { "/usr/bin/fish" }

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Frappe"]
custom.background = "#11111b" -- crust

local function deep_copy(obj)
	if type(obj) ~= "table" then
		return obj
	end
	local res = {}
	for k, v in pairs(obj) do
		res[k] = deep_copy(v)
	end
	return res
end

local ncurses_friendly = deep_copy(custom)
ncurses_friendly.ansi[5] = "#1e66f5"
ncurses_friendly.brights[5] = "#89b4fa"

config.color_schemes = {
	["Catppuccin Espresso"] = custom,
	["Catppuccin Espresso NCurses"] = ncurses_friendly,
}
config.color_scheme = "Catppuccin Espresso"

-- Add keybinding to toggle color scheme
config.keys = {
	{
		key = "T",
		mods = "CTRL|SHIFT",
		action = wezterm.action.EmitEvent("toggle-colorscheme"),
	},
}

wezterm.on("toggle-colorscheme", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.color_scheme == "Catppuccin Espresso NCurses" then
		overrides.color_scheme = "Catppuccin Espresso"
	else
		overrides.color_scheme = "Catppuccin Espresso NCurses"
	end
	window:set_config_overrides(overrides)
end)

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
