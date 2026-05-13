-- conf/rules.lua

-- Default: suppress maximize for all windows
hl.window_rule({
    name  = "defaults",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Simple float rules
hl.window_rule({ match = { class = "kbd-layout-viewer"          }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk"     }, float = true })
hl.window_rule({ match = { class = "org.gtk.example"            }, float = true })
hl.window_rule({ match = { class = "dev.mightycoderx.hypryomi"  }, float = true })

-- TigerVNC float
hl.window_rule({
    name   = "tigervnc-float",
    match  = { class = "Vncviewer" },
    center = true,
    float  = true,
})

-- TigerVNC viewer specific size
hl.window_rule({
    name             = "tigervnc-viewer-float",
    match            = { class = "Vncviewer", title = "WayVNC - TigerVNC" },
    persistent_size  = true,
    size             = { 1920, 1080 },
    center           = true,
})

-- Wezterm float
hl.window_rule({
    name        = "wezterm-float",
    match       = { class = "wez-float" },
    border_size = 2,
    center      = true,
    float       = true,
    size        = { 1280, 720 },
})

-- mpv webcam float
hl.window_rule({
    name              = "mpv-webcam-float",
    match             = { class = "mpv-webcam" },
    float             = true,
    center            = true,
    keep_aspect_ratio = true,
})

-- Blueman manager
hl.window_rule({
    name    = "blueman-manager-float",
    match   = { class = "blueman-manager" },
    float   = true,
    no_anim = true,
    move    = { "100%-w-0", "30" },
    size    = { 550, 400 },
    center  = true,
})

-- PulseAudio volume control
hl.window_rule({
    name    = "pavucontrol-float",
    match   = { class = "org.pulseaudio.pavucontrol" },
    float   = true,
    no_anim = true,
    move    = { "100%-w-0", "30" },
    size    = { 550, 400 },
    center  = true,
})

-- Network manager connection editor
hl.window_rule({
    name    = "nm-connection-editor-float",
    match   = { class = "nm-connection-editor" },
    float   = true,
    no_anim = true,
    move    = { "100%-w-0", "30" },
    size    = { 550, 400 },
})

-- Firefox PiP
hl.window_rule({
    name              = "firefox-pip-float",
    match             = { class = "firefox", title = "Picture-in-Picture" },
    float             = true,
    pin               = true,
    size              = { 720, 408 },
    keep_aspect_ratio = true,
})

hl.window_rule({
    match = { class = "firefox", title = "^(Extension: )(.*)$" },
    float = true,
})

-- Zen PiP
hl.window_rule({
    name              = "zen-pip-float",
    match             = { class = "zen", title = "Picture-in-Picture" },
    float             = true,
    pin               = true,
    size              = { 720, 408 },
    keep_aspect_ratio = true,
})

-- Zen profile chooser
hl.window_rule({
    name   = "zen-profile-float",
    match  = { class = "zen", title = "Zen - Choose User Profile" },
    float  = true,
    center = true,
    size   = { 720, 480 },
})

-- Electron open file dialog
hl.window_rule({
    name   = "electron-open-file-float",
    match  = { class = "electron", title = "Open File" },
    center = true,
    float  = true,
})

-- scrcpy
hl.window_rule({
    name              = "scrcpy-float",
    match             = { class = "scrcpy" },
    float             = true,
    center            = true,
    keep_aspect_ratio = true,
})

-- QEMU
hl.window_rule({
    name              = "qemu-system-float",
    match             = { class = "^(qemu-system)(.*)$" },
    float             = true,
    size              = { 1280, 720 },
    center            = true,
    keep_aspect_ratio = true,
})

-- Telegram media viewer
hl.window_rule({
    name  = "telegram-media-viewer-float",
    match = { class = "org.telegram.desktop", title = "Media viewer" },
    float = true,
})

-- Nextcloud
hl.window_rule({
    name  = "nextcloud-float",
    match = { class = "Nextcloud", title = "Nextcloud" },
    float = true,
    -- center intentionally disabled (see original comment)
})

hl.window_rule({
    name   = "nextcloud-settings-float",
    match  = { class = "Nextcloud", title = "Nextcloud Settings" },
    float  = true,
    center = true,
})

-----------------
-- Layer Rules --
-----------------

hl.layer_rule({ match = { namespace = "^(menu)$"     }, no_anim = true })  -- bemenu
hl.layer_rule({ match = { namespace = "^(wofi)$"     }, no_anim = true })
hl.layer_rule({ match = { namespace = "^(launcher)$" }, no_anim = true })  -- tofi

hl.layer_rule({
    name      = "rofi",
    match     = { namespace = "^(rofi)$" },
    no_anim   = true,
    dim_around = true,
    blur      = true,
    xray      = false,
})

hl.layer_rule({ match = { namespace = "^(swaync-control-center)$" }, no_anim = true })

-- Workspace rules
hl.workspace_rule({ workspace = "1",                  monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "special:scratchpad",  on_created_empty = terminal })
