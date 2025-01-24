{
  lib,
  config,
  system,
  nixpkgs,
  neovim-nightly-overlay,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  packages = import ./packages { inherit lib system pkgs; };
  programs = import ./programs {
    inherit
      lib
      config
      pkgs
      neovim-nightly-overlay
      ;
  };
  modules = import ./modules;
in
{
  imports = programs ++ modules;

  xdg.enable = true;

  home = {
    packages = packages;
    sessionVariables = {
      XDG_RUNTIME_DIR = "/run/user/$UID";
      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
