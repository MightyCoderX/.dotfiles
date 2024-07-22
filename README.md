# .dotfiles
Continuosly upgraded collection of useful configs and scripts to setup a new system


## TODOs
### Shell
- [ ] Choose a shell, see if I can stick to bash with a readline substitute or at max use zsh (no fish, cause it has fish bones, and is bloated!)
- [ ] Custom prompt with catppuccin colors


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
- [ ] Make it visible LMAO
- [ ] Use as login manager
- [ ] Add Input field
- [ ] Add date label
- [ ] Blur bg

#### Hypridle
- [x] Make screen turn off after some time
- [x] Suspend pc after another while


### Waybar

- [ ] Highlight current workspace with `[]` (code changes needed, could try to fork)
        (tried forking and did it but it's better to use another bar)
- [ ] Add distict styling for special workspaces
- [x] Open kbd-layout-viewer5 when clicking on kbd layout label


### NeoVIM

- [x] Color highlight [](https://github.com/brenoprata10/nvim-highlight-colors)
- [ ] Fix Shift+k keybind showing info without bg or border, which makes it blend too much with the bg
- [ ] Sort completions in the order: lsp, snippets, path?, buffer.. <https://www.reddit.com/r/neovim/comments/u3c3kw/how_do_you_sorting_cmp_completions_items/> 


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

