{
  self,
  nixpkgs,
  nix-darwin,
  home-manager,
  neovim-nightly-overlay,
  rust-overlay,
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
        home-manager.users."${username}" = import ../../home-manager {
          inherit
            lib
            system
            username
            home-dir
            nixpkgs
            neovim-nightly-overlay
            rust-overlay
            ;
        };
      }
    ];
  };
}
