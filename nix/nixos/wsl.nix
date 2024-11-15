{
  lib,
  pkgs,
  username,
  ...
}:
let
  isWsl = true;
  i18n = import ./config/i18n.nix;
  nix = import ./config/nix.nix;
  programs = import ./config/programs.nix { inherit lib pkgs; };
  security = import ./config/security.nix { inherit username; };
  systemd = import ./config/systemd.nix { inherit isWsl; };
  time = import ./config/time.nix;
  users = import ./config/users.nix { inherit pkgs username; };
  virtualisation = import ./config/virtualisation.nix;
  wsl = import ./config-wsl/wsl.nix;
in
{
  system.stateVersion = "24.05";
  imports = [
    i18n
    nix
    programs
    security
    systemd
    time
    users
    virtualisation
    wsl
  ];
}
