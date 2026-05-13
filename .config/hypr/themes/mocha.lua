-- themes/mocha.lua
-- Catppuccin Mocha palette, ported from mocha.conf

_G.rosewater  = "rgb(f5e0dc)"  ; _G.rosewaterAlpha  = "f5e0dc"
_G.flamingo   = "rgb(f2cdcd)"  ; _G.flamingoAlpha   = "f2cdcd"
_G.pink       = "rgb(f5c2e7)"  ; _G.pinkAlpha       = "f5c2e7"
_G.mauve      = "rgb(cba6f7)"  ; _G.mauveAlpha      = "cba6f7"
_G.red        = "rgb(f38ba8)"  ; _G.redAlpha        = "f38ba8"
_G.maroon     = "rgb(eba0ac)"  ; _G.maroonAlpha     = "eba0ac"
_G.peach      = "rgb(fab387)"  ; _G.peachAlpha      = "fab387"
_G.yellow     = "rgb(f9e2af)"  ; _G.yellowAlpha     = "f9e2af"
_G.green      = "rgb(a6e3a1)"  ; _G.greenAlpha      = "a6e3a1"
_G.teal       = "rgb(94e2d5)"  ; _G.tealAlpha       = "94e2d5"
_G.sky        = "rgb(89dceb)"  ; _G.skyAlpha        = "89dceb"
_G.sapphire   = "rgb(74c7ec)"  ; _G.sapphireAlpha   = "74c7ec"
_G.blue       = "rgb(89b4fa)"  ; _G.blueAlpha       = "89b4fa"
_G.lavender   = "rgb(b4befe)"  ; _G.lavenderAlpha   = "b4befe"
_G.text       = "rgb(cdd6f4)"  ; _G.textAlpha       = "cdd6f4"
_G.subtext1   = "rgb(bac2de)"  ; _G.subtext1Alpha   = "bac2de"
_G.subtext0   = "rgb(a6adc8)"  ; _G.subtext0Alpha   = "a6adc8"
_G.overlay2   = "rgb(9399b2)"  ; _G.overlay2Alpha   = "9399b2"
_G.overlay1   = "rgb(7f849c)"  ; _G.overlay1Alpha   = "7f849c"
_G.overlay0   = "rgb(6c7086)"  ; _G.overlay0Alpha   = "6c7086"
_G.surface2   = "rgb(585b70)"  ; _G.surface2Alpha   = "585b70"
_G.surface1   = "rgb(45475a)"  ; _G.surface1Alpha   = "45475a"
_G.surface0   = "rgb(313244)"  ; _G.surface0Alpha   = "313244"
_G.base       = "rgb(1e1e2e)"  ; _G.baseAlpha       = "1e1e2e"
_G.mantle     = "rgb(181825)"  ; _G.mantleAlpha     = "181825"
_G.crust      = "rgb(11111b)"  ; _G.crustAlpha      = "11111b"

-- Apply theme-dependent config options
hl.config({
    general = {
        col = {
            active_border   = "rgba(89b4faaa)",  -- blue   + aa opacity
            inactive_border = "rgba(45475aaa)",  -- surface1 + aa opacity
        },
    },
    decoration = {
        shadow = {
            color = "rgba(11111b99)",  -- crust + 99 opacity
        },
    },
    misc = {
        background_color = "rgb(181825)",  -- mantle
    },
})
