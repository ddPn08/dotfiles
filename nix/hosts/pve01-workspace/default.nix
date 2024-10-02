{
  self,
  nixpkgs,
  nix-darwin,
  home-manager,
  nixos-vscode-server,
  neovim-nightly-overlay,
  rust-overlay,
}:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  username = "ddpn08";
  home-dir = "/home/${username}";
in
{
  pve01-workspace = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit username;
    };
    modules = [
      ../../nixos
      ./hardware-configuration.nix
      nixos-vscode-server.nixosModules.default
      home-manager.nixosModules.home-manager
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
