# .dotfiles
My dotfiles

## Hypr

### Hyprland
- [ ] Add binds to cycle workspaces
- [ ] Blur background workspace when in special workspace
- [x] Change special workspace show animation
- [ ] Make keybind to display list of open windows in used order (hyprswitch does this)
    ```shell
    hyprctl dispatch workspace $(hyprctl clients -j | jq -rs '.[] | sort_by(.focusHistoryID) | .[] | [.workspace.id, .class, .title] | @tsv' | wofi --show dmenu | cut -f1)
    ```

### Hyprlock
- [ ] Use as login manager
- [ ] Add Input field
- [ ] Add date label
- [ ] Blur bg

### Hypridle
- [ ] Make screen turn off after some time
- [ ] Suspend pc after another whil Suspend pc after another while

## Waybar
- [ ] Highlight current workspace with `[]` (code changes needed, could try to fork)
- [ ] Add distict styling for special workspaces


## NeoVIM
- [ ] Color highlight [](https://github.com/brenoprata10/nvim-highlight-colors)
- [ ] Fix completions


## dunst
- [ ] Make a notification history widget (switch to SwayNotificationCenter for ready made one)
    ```
    dunstctl history | jq -rs '.[] | .data[0] | .[] | map_values( .data ) | [.appname, .summary, .body] | @csv'
    ```

## (AGS bar)[https://github.com/Aylur/ags]
- [ ] Try it


## Eww bar


## iced-rs
Rust UI library which I could use to make a top bar


