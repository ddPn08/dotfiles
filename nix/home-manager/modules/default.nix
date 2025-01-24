let
  haskell = import ./haskell;
  k8s = import ./k8s;
  proto = import ./proto;
  python = import ./python;
  rustup = import ./rustup;
  wezterm = import ./wezterm;
in
[
  haskell
  k8s
  proto
  python
  rustup
  wezterm
]
