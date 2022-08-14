set fish_greeting "$fish_greeting MSYS2"

# aliases
alias nt "script -c tmux /dev/null"

# env
set -x SHELL "$(which fish)"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_STATE_HOME "$HOME/.local/state"
