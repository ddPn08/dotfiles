let
  haskell = import ./haskell;
  pnpm = import ./pnpm;
  python = import ./python;
  rustup = import ./rustup;
  tuicr = import ./tuicr;
  wezterm = import ./wezterm;
in
[
  haskell
  pnpm
  python
  rustup
  tuicr
  wezterm
]
