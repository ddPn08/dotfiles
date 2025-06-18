{ pkgs, username, ... }:
let
  fonts = import ./config/fonts.nix { inherit pkgs; };
  homebrew = import ./config/homebrew.nix;
  nix = import ./config/nix.nix;
  programs = import ./config/programs.nix;
  security = import ./config/security.nix { inherit username; };
  services = import ./config/services.nix;
  system = import ./config/system.nix { inherit pkgs; };
  users = import ./config/users.nix { inherit pkgs username; };
in
{
  imports = [
    fonts
    homebrew
    nix
    programs
    security
    services
    system
    users
  ];
}
