{
  nixpkgs,
  home-manager,
  neovim-nightly-overlay,
  ...
}:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  defaultUsername = "ddpn08";
  envUsername = builtins.getEnv "PORTABLE_USERNAME";
  username =
    if envUsername != "" then envUsername else defaultUsername;
  envHome = builtins.getEnv "PORTABLE_HOME";
  home-dir =
    if envHome != "" then envHome else "/home/${username}";
in
{
  portable = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit
        system
        username
        home-dir
        nixpkgs
        neovim-nightly-overlay
        ;
    };
    modules = [
      ({ ... }: {
        home.username = username;
        home.homeDirectory = home-dir;
      })
      ({ config, lib, ... }:
        import ../../home-manager {
          inherit
            config
            lib
            system
            username
            home-dir
            nixpkgs
            neovim-nightly-overlay
            ;
        }
      )
    ];
  };
}
