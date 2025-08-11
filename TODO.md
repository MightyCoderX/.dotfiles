# TODOs

## Setup

- [ ] Try to move all commits related to new setup.sh system to a different branch
- [x] Put eza and tz aliases in their respective setup dirs
    alongside the commands to install them
- [ ] Consider moving script.sh to ./setup/setup
- [ ] Add home setup directory to copy home dotfiles
- [ ] Consider renaming ./setup to ./steps
- [x] Create Dockerfile's to test on fedora and arch
- [ ] Move `.local` to `home`
- [ ] Move `scripts` to `home/.local/scripts` (update all references in configs)
- [ ] Move `shell` to `.config/shell` (see if it doesn't conflict with any package)
- [ ] Move `.config` in `home` (UPDATE ALL SYMLINKS!)
- [ ] Think about saving browser data
- [ ] add flag to toggle installation of config if already present (take inspiration from /usr/share/doc/util-linux/getopt-example.bash)
- [ ] Create config to choose exactly what to install where each line is a flag
- [ ] Add uninstall script for each setup subdirectory

## Shell

- [x] Choose a shell, see if I can stick to bash with a readline substitute or at max use zsh ~~(no fish, cause it has fish bones, and is bloated!)~~ I use fish now :D
- [x] Custom prompt with catppuccin colors

## tmux

- [x] Fix slow startup (almost 1s) due to catpuccin theme plugins
  - [x] Opened issue on GitHub
  - [x] Wait for them to fix, ~~and help them by coming up with a way to batch the tmux commands~~
- [ ] Make a basic bash "module" with simple functions to create windows and panels to use in session scripts

## Hypr

### Hyprland

- [x] Add binds to cycle workspaces
- [x] Blur background workspace when in special workspace
- [x] Change special workspace show animation
- [ ] Make keybind to display list of open windows in used order (hyprswitch does this)

    ```shell
    hyprctl dispatch workspace $(hyprctl clients -j | jq -rs '.[] | sort_by(.focusHistoryID) | .[] | [.workspace.id, .class, .title] | @tsv' | wofi --show dmenu | cut -f1)
    ```

- [x] Show power menu for Super-Shift-Q instead of just killing Hyprland
- [x] Create resize submap started with SUPER+R

### Hyprlock

- [x] Make it visible LMAO
- [ ] Use as login manager
- [x] Add Input field
- [x] Add date label
- [x] Blur bg
- [ ] Fix numlock disabled even if it looks enabled

### Hypridle

- [x] Make screen turn off after some time
- [x] Suspend pc after another while

## Waybar

- [ ] Highlight current workspace with `[]` (code changes needed, could try to fork)
        (tried forking and did it but it's better to use another bar)
- [ ] Add distict styling for special workspaces
- [x] Open kbd-layout-viewer5 when clicking on kbd layout label
- [ ] Hide tray icons for blueman and nm-applet
- [ ] Unify wifi, bluetooth and other icons in popup widget

## NeoVIM

- [x] Color highlight [](https://github.com/brenoprata10/nvim-highlight-colors)
- [x] Fix Shift+k keybind showing info without bg or border, which makes it blend too much with the bg
- [ ] Sort completions in the order: lsp, snippets, path?, buffer.. [](https://www.reddit.com/r/neovim/comments/u3c3kw/how_do_you_sorting_cmp_completions_items/)
- [ ] Add useful plugins from kickstart.nvim [](https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua)
- [ ] Add markdown preview plugin

## dunst

- [x] Make a notification history widget (switch to SwayNotificationCenter for ready made one)

    ```
    dunstctl history | jq -rs '.[] | .data[0] | .[] | map_values( .data ) | [.appname, .summary, .body] | @csv'
    ```

## SwayNC

- [x] Style and configure

## Eww bar

- [x] Make a simple bar and see if I can sourround workspace in `[]`
- [ ] Make the bar display only workspaces on current monitor
- [ ] Add tooltips

## iced-rs

Rust UI library which I could use to make a top bar

## bemenu

- [x] Improve scripts

## Wayvnc

- [ ] use submodule to store .config/wayvnc in seprarate private repo since it contains sensitive information?
