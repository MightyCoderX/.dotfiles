# TERM='xterm-256color'
export LESS='-R --mouse'
export MANPAGER='nvim +"Man!" +"set mouse=a"'

export PATH="$HOME/.local/bin:$PATH"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export PATH="$HOME/go/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"
export RUSTC_WRAPPER=sccache

export ANDROID_USER_HOME="$XDG_DATA_HOME/android"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"

export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

export WINEPREFIX="$XDG_DATA_HOME/wine"

export COWPATH="$COWPATH:$HOME/.local/share/cowsay/extra"
