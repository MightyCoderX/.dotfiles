-- conf/input.lua

local mouse    = "steelseries-steelseries-rival-3"
local touchpad = "msnb0001:00-06cb:7e7e-touchpad"

hl.config({
    input = {
        kb_layout  = "it,jp",
        kb_variant = "",
        kb_model   = "",
        kb_options = "caps:swapescape",
        kb_rules   = "",

        numlock_by_default = true,
        repeat_delay       = 300,
        repeat_rate        = 50,

        follow_mouse             = 2,
        float_switch_override_focus = 0,
        special_fallthrough      = false,

        sensitivity   = -0.8,
        scroll_factor = 0.8,

        touchpad = {
            natural_scroll      = true,
            clickfinger_behavior = true,
        },
    },

    gestures = {
        -- workspace_swipe                    = true,
        -- workspace_swipe_distance           = 700,
        -- workspace_swipe_fingers            = 3,
        -- workspace_swipe_cancel_ratio       = 0.2,
        -- workspace_swipe_min_speed_to_force = 3,
        -- workspace_swipe_direction_lock     = true,
        -- workspace_swipe_direction_lock_threshold = 10,
        -- workspace_swipe_create_new         = true,
    },
})

hl.device({
    name        = mouse,
    sensitivity = -0.8,
})

hl.device({
    name        = touchpad,
    sensitivity = 0.8,
    enabled     = false,
})
