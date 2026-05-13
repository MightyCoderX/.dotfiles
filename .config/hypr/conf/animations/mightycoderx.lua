-- conf/animations/mightycoderx.lua
-- Not loaded by default. To use: require("conf.animations.mightycoderx") in conf/animations.lua

hl.curve("myBezier", { type = "bezier", points = { {0.8, 0.02}, {0.9, 0.8} } })

hl.animation({ leaf = "windows",          enabled = true, speed = 1.5, bezier = "myBezier", style = "popin"           })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 1.5, bezier = "myBezier", style = "popin"           })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 1,   bezier = "myBezier", style = "slide"           })
hl.animation({ leaf = "border",           enabled = true, speed = 7,   bezier = "default"   })
hl.animation({ leaf = "borderangle",      enabled = true, speed = 8,   bezier = "default"   })
hl.animation({ leaf = "fade",             enabled = true, speed = 7,   bezier = "default"   })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.5, bezier = "myBezier", style = "slidefade 20%"   })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1,   bezier = "default",  style = "slidefadevert -30%" })
