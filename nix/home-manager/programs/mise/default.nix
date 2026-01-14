
{ pkgs, ... }:
let
  version = "2026.1.1";
  src = pkgs.fetchFromGitHub {
    owner = "jdx";
    repo = "mise";
    rev = "v${version}";
    hash = "sha256-z2sk7g0XleaV83udcxqvlyqit3NPcqbcttN6Zo9asdI=";
  };
in
{
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.mise.overrideAttrs (oldAttrs: {
      inherit version src;
      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        inherit src;
        name = "mise-${version}-vendor";
        hash = "sha256-zau4N7TsgcKmG5AUdUm1WL3AKqT7d8CqTnjnUgqYDvU=";
      };
    });
  };
}
