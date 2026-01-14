{
  lib,
  pkgs,
}:
let
  stdenv = pkgs.stdenv;

  nix-utils = with pkgs; [
    nil
    statix
    nixfmt
    nix-prefetch-scripts
  ];

  base = with pkgs; [
    # Cloud & platform CLIs
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    (google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
    ))
    cloudflared
    stripe-cli

    # Kubernetes tooling
    kubectl
    kustomize
    kubernetes-helm
    sops
    docker-credential-helpers

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
    envsubst

    # Developer productivity
    act
    claude-code
    codex
    # dotenvx # TODO: nixpkgs package broken, re-add when fixed
    gemini-cli
    ffmpeg
    google-cloud-sql-proxy
    mariadb.client
    uv
    wasm-pack
    terraform
  ];
  darwin-pkgs = with pkgs; [
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
