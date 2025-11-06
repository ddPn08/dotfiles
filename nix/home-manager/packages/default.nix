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
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])

    # Essential tools
    vim
    wget
    curl
    git
    git-lfs
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
    mariadb.client
    act
    claude-code
    codex
    uv
    cloudflared
    ffmpeg

    # kubernetes
    kubectl
    kubernetes-helm
    cloudflared
    sops
  ];
  darwin-pkgs = with pkgs; [
    ios-deploy
    s3fs
    mas
  ];
  linux-pkgs = with pkgs; [
    gcc
  ];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin-pkgs else [ ])
  (if stdenv.isLinux then linux-pkgs else [ ])
  base
  nix-utils
]
