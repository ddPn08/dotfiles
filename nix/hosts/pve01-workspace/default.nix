{
  nixpkgs,
  home-manager,
  nixos-vscode-server,
  neovim-nightly-overlay,
}:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  username = "ddpn08";
  home-dir = "/home/${username}";
in
lib.nixosSystem {
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
      home-manager.users."${username}" =
        { config, ... }:
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
}
