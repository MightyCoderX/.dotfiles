-- conf/window.lua
-- NOTE: col.active_border and col.inactive_border reference variables from your
-- mocha theme (blueAlphaaa, surface1Alphaaa). Make sure themes/mocha.lua sets
-- those as globals before this file is loaded.

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 8,

        border_size = 0,
        -- no_border_on_floating = false,

        -- col.active_border   = ...,  -- set these in your theme file or here:
        -- col.inactive_border = ...,

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
        no_focus_fallback = true,
    },
})
