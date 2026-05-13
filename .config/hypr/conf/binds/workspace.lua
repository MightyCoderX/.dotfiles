-- conf/binds/workspace.lua

-- Switch to workspace
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))

-- Switch to last focused window
hl.bind("ALT + Tab", hl.dsp.focus({ window = "currentorlast" }))

-- Move current workspace to monitor
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.workspace.move({ monitor = "-1" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.workspace.move({ monitor = "+1" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspaces (scratchpad)
hl.bind(mainMod .. " + S",          hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + S",  hl.dsp.window.move({ workspace = "special:scratchpad" }))
