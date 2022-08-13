set fish_greeting "🐼"

# aliases
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-msys.fish
end