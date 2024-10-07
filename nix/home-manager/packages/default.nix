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
    nodejs_20
    nodePackages.pnpm
    kubectl
  ];
  darwin = with pkgs.darwin; [ ios-deploy ];
  linux = with pkgs; [ ];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin else [ ])
  (if stdenv.isLinux then linux else [ ])
  base
  nix-utils
]
