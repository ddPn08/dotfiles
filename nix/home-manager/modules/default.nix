let
  haskell = import ./haskell;
  k8s = import ./k8s;
  pnpm = import ./pnpm;  
  proto = import ./proto;
  python = import ./python;
  rustup = import ./rustup;
  wezterm = import ./wezterm;
in
[
  haskell
  k8s
  proto
  pnpm
  python
  rustup
  wezterm
]
