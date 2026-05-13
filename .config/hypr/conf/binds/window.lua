-- conf/binds/window.lua

-- Kill / fullscreen / float / pin
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + ALT + F",     hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + P",   hl.dsp.window.pin())

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Move window
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "d" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272",          hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",          hl.dsp.window.resize(), { mouse = true })
-- hl.bind(mainMod .. " + SHIFT + mouse:273",  hl.dsp.window.resize({ x = 1, y = 1, keep_aspect_ratio = true }), { mouse = true })

-- Move active window to workspace silently
for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i), silent = true }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", silent = true }))

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", "reset", function()
    local amount = 20
    hl.bind("right", hl.dsp.window.resize({ x =  amount, y = 0       }), { repeating = true })
    hl.bind("left",  hl.dsp.window.resize({ x = -amount, y = 0       }), { repeating = true })
    hl.bind("up",    hl.dsp.window.resize({ x = 0,       y = -amount }), { repeating = true })
    hl.bind("down",  hl.dsp.window.resize({ x = 0,       y =  amount }), { repeating = true })
    hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
    hl.bind("escape",           hl.dsp.submap("reset"))
end)
