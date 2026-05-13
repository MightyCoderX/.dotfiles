-- conf/binds/exec.lua

local sd = scriptsDir  -- set in hyprland.lua

-- Programs
hl.bind(mainMod .. " + Return",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(terminal .. " start --class wez-float"))
hl.bind(mainMod .. " + E",            hl.dsp.exec_cmd(sd .. "/rofi-emoji.sh"))
hl.bind(mainMod .. " + V",            hl.dsp.exec_cmd(sd .. "/clipboard-manager.sh"))
hl.bind(mainMod .. " + PERIOD",       hl.dsp.exec_cmd(terminal .. " start bash -i -c '\\cd ~/.dotfiles/scripts/tmux-sessions; ./dotfiles.sh'"))
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd(sd .. "/bemenu.sh"))
hl.bind(mainMod .. " + D",            hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + L",            hl.dsp.exec_cmd("pidof hyprlock || hyprlock"))
hl.bind(mainMod .. " + SHIFT + R",    hl.dsp.exec_cmd(sd .. "/reload_waybar.sh"))
hl.bind(mainMod .. " + N",            hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SHIFT + Q",    hl.dsp.exec_cmd(sd .. "/powermenu.sh"))
hl.bind(mainMod .. " + B",            hl.dsp.exec_cmd(browser .. " -P"))
hl.bind(mainMod .. " + CTRL + J",     hl.dsp.exec_cmd(browser .. " 'https://jotoba.de/search/$(wl-paste -p)'"))
hl.bind(mainMod .. " + ALT + J",      hl.dsp.exec_cmd(browser .. " 'https://jotoba.de/search/$(grim -g \"$(slurp)\" - | tesseract - - -l jpn | tr -d \" \")'"))
hl.bind(mainMod .. " + T",            hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tesseract - - -l en | wl-copy"))
hl.bind(mainMod .. " + C",            hl.dsp.exec_cmd(terminal .. " start --class wez-float qalc"))
hl.bind(mainMod .. " + SHIFT + C",    hl.dsp.exec_cmd("hyprpicker -a && notify-send -i color_palette -a 'System' 'Color Picker' 'Copied color to clipboard'"))
hl.bind(mainMod .. " + O",            hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tesseract - - -l eng -l ita | wl-copy"))
hl.bind(mainMod .. " + CTRL + W",     hl.dsp.exec_cmd(sd .. "/webcam.sh"))
hl.bind(mainMod .. " + SHIFT + B",    hl.dsp.exec_cmd(sd .. "/bluetooth-toggle-connection.sh"))

-- Screenshots
local screenshot     = sd .. "/screenshot.sh"
hl.bind("Print",               hl.dsp.exec_cmd(screenshot .. " copysave area"))
hl.bind("ALT + Print",         hl.dsp.exec_cmd(screenshot .. " edit area"))
hl.bind("SHIFT + Print",       hl.dsp.exec_cmd(screenshot .. " copysave screen"))
hl.bind(mainMod .. " + Print",          hl.dsp.exec_cmd(screenshot .. " copysave output"))
hl.bind(mainMod .. " + SHIFT + Print",  hl.dsp.exec_cmd(screenshot .. " copysave active"))

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 5%-"),        { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"),        { repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SOURCE@ toggle"),      { repeating = true })

-- Playback
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"),   { repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"),       { repeating = true })

-- Touchpad toggle
hl.bind("CTRL + SUPER + XF86TouchpadToggle", hl.dsp.exec_cmd(sd .. "/toggle_touchpad.sh"), { repeating = true })
