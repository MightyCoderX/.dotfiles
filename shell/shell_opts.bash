shopt -s autocd   # Enable autocd to change dir by just typing the path
shopt -s nullglob # Enable nullglob so that globs that don't match files don't return the glob string but return an empty one
shopt -s globstar # Enable globstar which allows for recursive globbing with **
#shopt -s dotglob  # Enable dotglob which includes dotfiles in * glob

set -o noclobber # Disable overriding files with redirection
