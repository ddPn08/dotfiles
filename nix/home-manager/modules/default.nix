let
  haskell = import ./haskell;
  pnpm = import ./pnpm;
  python = import ./python;
  rustup = import ./rustup;
  wezterm = import ./wezterm;
in
[
  haskell
  pnpm
  python
  rustup
  wezterm
]
