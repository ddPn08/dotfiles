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
    (proto.overrideAttrs (drv: rec {
      name = "proto";
      version = "0.44.5";

      src = pkgs.fetchFromGitHub {
        owner = "moonrepo";
        repo = "proto";
        rev = "v${version}";
        sha256 = "sha256-4ZmXJAHDEExn3aAlLd+Upopj9TZb1fOm+Zil0CoTsk4=";
      };

      cargoDeps = drv.cargoDeps.overrideAttrs (
        lib.const {
          name = "${name}-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-T0Le1hIBWKqgn7mgrZEHW8ZE/gqFI6+v0ouqvjAyj7E=";
        }
      );
    }))

    # kubernetes
    kubectl
    kubernetes-helm
    cloudflared
    sops
  ];
  darwin-pkgs = with pkgs; [
    ios-deploy
  ];
  linux-pkgs = with pkgs; [ ];
in
lib.mkMerge [
  (if stdenv.isDarwin then darwin-pkgs else [ ])
  (if stdenv.isLinux then linux-pkgs else [ ])
  base
  nix-utils
]
