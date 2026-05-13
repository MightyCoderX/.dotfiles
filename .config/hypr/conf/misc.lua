-- conf/misc.lua
-- NOTE: background_color references $mantle from your mocha theme.
-- Load your theme before this file, or set it directly as a hex value here.

require("themes.mocha")

hl.config({
    misc = {
        vrr = 3,

        force_default_wallpaper = 1,
        disable_hyprland_logo   = true,

        -- background_color = ...,  -- set from mocha theme ($mantle)

        focus_on_activate        = true,
        allow_session_lock_restore = true,
        on_focus_under_fullscreen  = 0,

        middle_click_paste = false,
    },
})
