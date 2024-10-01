{
  lib,
  system,
  username,
  home-dir,
  nixpkgs,
  neovim-nightly-overlay,
  rust-overlay,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [ rust-overlay.overlays.default ];
  };
  packages = import ./packages { inherit lib system pkgs; };
  programs = import ./programs { inherit lib pkgs neovim-nightly-overlay; };
  modules = import ./modules { inherit pkgs; };
in
{
  imports = programs ++ modules;

  xdg.enable = true;

  home = {
    stateVersion = "24.05";
    packages = packages;
  };
  programs.home-manager.enable = true;
  programs.zsh.enable = true;
}
