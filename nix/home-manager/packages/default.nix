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
    # Essential tools
    wget
    curl
    git
    rclone
    zstd
    act
    ncdu
    wasm-pack
    proto
    lsof
    uv
    stripe-cli
    dotenvx
    mariadb-client
    act
    claude-code

    # kubernetes
    kubectl
    kubernetes-helm
    cloudflared
    sops
  ];
  darwin-pkgs = with pkgs; [
    ios-deploy
  ];
  linux-pkgs = with pkgs; [];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin-pkgs else [ ])
  (if stdenv.isLinux then linux-pkgs else [ ])
  base
  nix-utils
]
