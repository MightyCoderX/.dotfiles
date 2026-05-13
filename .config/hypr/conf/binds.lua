-- conf/binds.lua

local mainMod = "SUPER"
_G.mainMod = mainMod  -- make available to sub-modules

require("conf.binds.exec")
require("conf.binds.window")
require("conf.binds.layout")
require("conf.binds.workspace")
