{
  description = "Minimal package definition for aarch64-darwin";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      nixos-wsl,
      nixos-vscode-server,
      neovim-nightly-overlay,
      rust-overlay,
      ...
    }:
    {
      darwinConfigurations = (
        import ./nix/hosts/mba {
          inherit
            self
            nixpkgs
            nix-darwin
            home-manager
            neovim-nightly-overlay
            rust-overlay
            ;
        }
      );
      nixosConfigurations = {
        pve01-workspace = import ./nix/hosts/pve01-workspace {
          inherit
            nixpkgs
            home-manager
            nixos-vscode-server
            neovim-nightly-overlay
            rust-overlay
            ;
        };
        wsl = import ./nix/hosts/wsl {
          inherit
            nixpkgs
            nixos-wsl
            home-manager
            neovim-nightly-overlay
            rust-overlay
            ;
        };
      };
    };
}
