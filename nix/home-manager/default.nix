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
    packages = packages;
    sessionVariables = {
      KUBECONFIG = "${home-dir}/data/k8s/kubeconfig";
    };
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
