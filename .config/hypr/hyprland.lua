-- hyprland.lua
-- Main entry point. Mirrors old hyprland.conf structure.
-- Requires hyprland >= 0.55

local scriptsDir = os.getenv("HOME") .. "/.dotfiles/scripts"

-- Make scriptsDir available globally so sub-modules can use it
_G.scriptsDir = scriptsDir

require("conf.monitor")
require("conf.environment")
require("conf.programs")
require("conf.autostart")
require("conf.window")
require("conf.decorations")
require("conf.animations")
require("conf.layout")
require("conf.misc")
require("conf.input")
require("conf.binds")
require("conf.rules")

hl.config({ debug = { disable_logs = false } })
