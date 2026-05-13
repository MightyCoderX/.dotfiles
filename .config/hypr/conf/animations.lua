-- conf/animations.lua

hl.config({
    animations = {
        enabled = true,
    },
})

-- Disable popup fade animation
hl.animation({ leaf = "fadePopups", enabled = false, speed = 0, bezier = "default" })

-- Load smoother preset
require("conf.animations.smoother")
