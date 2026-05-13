-- conf/decorations.lua
-- NOTE: shadow.color references crustAlpha99 from your mocha theme.

hl.config({
    decoration = {
        rounding       = 10,
        rounding_power = 3,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        dim_special  = 0.5,
        dim_inactive = false,
        dim_strength = 0.2,

        shadow = {
            enabled      = true,
            range        = 15,
            render_power = 5,
            -- color = 0x99<crustHex>,  -- set from your theme; original: rgba($crustAlpha99)
        },

        blur = {
            enabled = true,
            size    = 3,
            passes  = 2,
            special = true,
            popups  = false,
        },
    },
})
