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
HISTFILE=~/.histfile
HISTSIZE=1000000000
SAVEHIST=1000000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups

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
autoload -Uz compinit && compinit

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
source "$HOME/.dotfiles/shell/zle_keybinds.zsh" 

# Aliases
source "$HOME/.dotfiles/shell/aliases.sh"

# Shell integrations
eval "$(fzf --zsh)"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#04a5e5,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#04a5e5,hl+:#f38ba8"

eval "$(oh-my-posh init zsh --config ~/.dotfiles/.config/ohmyposh/catppuccin_mocha.toml)"


##########################
## Dev package managers ##
##########################

# cargo
. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="/home/mcx/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="$HOME/go/bin:$PATH"

source "$HOME/.dotfiles/shell/variables.sh"

