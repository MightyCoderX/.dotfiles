# .dotfiles
Continuosly upgraded collection of useful configs and scripts to setup a new system

## TODOs
### Hypr
#### Hyprland
- [ ] Add binds to cycle workspaces
- [ ] Blur background workspace when in special workspace
- [x] Change special workspace show animation
- [ ] Make keybind to display list of open windows in used order (hyprswitch does this)
    ```shell
    hyprctl dispatch workspace $(hyprctl clients -j | jq -rs '.[] | sort_by(.focusHistoryID) | .[] | [.workspace.id, .class, .title] | @tsv' | wofi --show dmenu | cut -f1)
    ```
- [ ] Make firefox open in a tabbed view (probably have to use hyprland groups)

#### Hyprlock
- [ ] Use as login manager
- [ ] Add Input field
- [ ] Add date label
- [ ] Blur bg

#### Hypridle
- [ ] Make screen turn off after some time
- [ ] Suspend pc after another while


### Waybar

- [ ] Highlight current workspace with `[]` (code changes needed, could try to fork)
- [ ] Add distict styling for special workspaces
- [ ] Open kdb-layout-viewer5 when clicking on kbd layout label


### NeoVIM

- [ ] Color highlight [](https://github.com/brenoprata10/nvim-highlight-colors)
- [ ] Fix completions


### dunst

- [x] Make a notification history widget (switch to SwayNotificationCenter for ready made one)
    ```
    dunstctl history | jq -rs '.[] | .data[0] | .[] | map_values( .data ) | [.appname, .summary, .body] | @csv'
    ```


### SwayNC

- [ ] Style and configuure


### Eww bar

- [ ] Make a simple bar and see if I can sourround workspace in `[]`


### iced-rs

Rust UI library which I could use to make a top bar


