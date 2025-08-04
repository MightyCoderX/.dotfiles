if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Clone zinit if not already present
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# History
source "$HOME/.dotfiles/shell/history.zsh"

# Add help command to show shell builtins like bash
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle :compinstall filename '/home/mcx/.zshrc'
zstyle ':completion:*' rehash true
autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Keybinds
source "$HOME/.dotfiles/shell/zle_keybinds.zsh" 

# Aliases
source "$HOME/.dotfiles/shell/aliases.sh"

# Shell integrations
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#04a5e5,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#04a5e5,hl+:#f38ba8"

eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/catppuccin_mocha.toml)"

source "$HOME/.dotfiles/shell/variables.sh"

eval "$(zoxide init zsh)"
eval "$(eww shell-completions --shell zsh)"
eval "$(arduino-cli completion zsh)"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

asmfetch
