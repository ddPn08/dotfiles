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
    # Cloud & platform CLIs
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    (google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]))
    cloudflared
    stripe-cli

    # Kubernetes tooling
    kubectl
    kubernetes-helm
    sops

    # Core CLI essentials
    curl
    git
    git-lfs
    lsof
    ncdu
    rclone
    vim
    wget
    zstd

    # Developer productivity
    act
    claude-code
    codex
    dotenvx
    ffmpeg
    mariadb.client
    proto
    uv
    wasm-pack
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
