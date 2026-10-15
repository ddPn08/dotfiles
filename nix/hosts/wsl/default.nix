{
  nixpkgs,
  nixos-wsl,
  home-manager,
  neovim-nightly-overlay,
  tuicr,
  ...
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
    ../../nixos/wsl.nix
    nixos-wsl.nixosModules.wsl
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
            tuicr
            ;
        };
    }
  ];
}
