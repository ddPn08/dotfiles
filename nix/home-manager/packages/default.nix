{
  lib,
  pkgs,
}:
let
  stdenv = pkgs.stdenv;

  nix-utils = with pkgs; [
    nil
    nixd
    statix
    nixfmt
    nix-prefetch-scripts
  ];

  base = with pkgs; [
    # Search & find utilities (required by neovim plugins)
    fd
    ripgrep

    # Cloud & platform CLIs
    (azure-cli.withExtensions [ azure-cli.extensions.aks-preview ])
    (google-cloud-sdk.withExtraComponents (
      with pkgs.google-cloud-sdk.components; [ gke-gcloud-auth-plugin ]
    ))
    cloudflared
    stripe-cli

    # Kubernetes tooling
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
    rsync
    ffmpeg
    dotenvx

    # AI Agents
    codex
    antigravity

    # haskell
    (haskellPackages.hpack)
    (haskellPackages.hoogle)
    (haskellPackages.stylish-haskell)
  ];
  darwin-pkgs = with pkgs; [
    mas
  ];
  linux-pkgs = with pkgs; [
    gcc
    python3
  ];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin-pkgs else [ ])
  (if stdenv.isLinux then linux-pkgs else [ ])
  base
  nix-utils
]
