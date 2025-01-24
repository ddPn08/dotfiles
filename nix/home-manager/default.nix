{
  lib,
  config,
  system,
  home-dir,
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
  modules = import ./modules { inherit pkgs; };
in
{
  imports = programs ++ modules;

  xdg.enable = true;

  home = {
    packages = packages;
    sessionVariables = {
      KUBECONFIG = "${home-dir}/data/k8s/kubeconfig";
    };
    stateVersion = "25.05";
  };
  programs.home-manager.enable = true;
}
