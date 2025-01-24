{
  self,
  nixpkgs,
  nix-darwin,
  home-manager,
  neovim-nightly-overlay,
}:
let
  lib = nixpkgs.lib;
  system = "aarch64-darwin";
  username = "ddpn08";
  home-dir = "/Users/${username}";
  configuration =
    { ... }:
    {
      users.users.${username} = {
        home = home-dir;
      };
    };
in
{
  ddpn08-darwin = nix-darwin.lib.darwinSystem {
    inherit system lib;
    specialArgs = {
      inherit username;
    };
    modules = [
      configuration
      ../../nix-darwin
      home-manager.darwinModules.home-manager
      {
        home-manager.useUserPackages = true;
        home-manager.users."${username}" =
          { config, ...}:
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
          };
      }
    ];
  };
}
