# install nushell
brew install nushell tmux nvim starship

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

nu setup.nu