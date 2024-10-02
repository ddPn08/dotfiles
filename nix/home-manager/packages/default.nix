{
  lib,
  system,
  pkgs,
}:
let
  stdenv = pkgs.stdenv;

  nix-utils = with pkgs; [
    nil
    nixfmt-rfc-style
    nix-prefetch-scripts
  ];
  base = with pkgs; [
    rust-bin.stable.latest.default
    uv
  ];
  darwin = with pkgs.darwin; [ ios-deploy ];
  linux = with pkgs; [ ];
  windows = with pkgs; [ ];
  isWindows = system == "x86_64-windows";
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin else [ ])
  (if stdenv.isLinux then linux else [ ])
  (if isWindows then windows else [ ])
  base
  nix-utils
]
