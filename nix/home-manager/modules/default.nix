let
  haskell = import ./haskell;
  pnpm = import ./pnpm;  
  proto = import ./proto;
  python = import ./python;
  rustup = import ./rustup;
  wezterm = import ./wezterm;
in
[
  haskell
  proto
  pnpm
  python
  rustup
  wezterm
]
