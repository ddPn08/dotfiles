{ pkgs }:
{
  nix = {
    enable = true;
    linux-builder = {
      enable = true;
      package = pkgs.darwin.linux-builder-x86_64;
      systems = [ "x86_64-linux" ];
    };
    optimise.automatic = true;
    settings = {
      experimental-features = "nix-command flakes";
      max-jobs = 8;
      trusted-users = [ "ddpn08" ];
    };
    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
