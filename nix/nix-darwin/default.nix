{ pkgs, username, ... }:
let
  nix = import ./config/nix.nix;
  fonts = import ./config/fonts.nix { inherit pkgs; };
  security = import ./config/security.nix { inherit username; };
  services = import ./config/services.nix;
  system = import ./config/system.nix { inherit pkgs; };
  homebrew = import ./config/homebrew.nix;
in
{
  imports = [
    nix
    fonts
    security
    services
    system
    homebrew
  ];
}
