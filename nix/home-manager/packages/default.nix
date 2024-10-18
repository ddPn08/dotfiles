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
    uv
    kubectl
    proto
    act
    kubectl
    ncdu
    kubernetes-helm
    cloudflared
    sops
  ];
  darwin-pkgs = with pkgs; [
    darwin.ios-deploy
  ];
  linux-pkgs = with pkgs; [ ];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin-pkgs  else [ ])
  (if stdenv.isLinux then linux-pkgs else [ ])
  base
  nix-utils
]
