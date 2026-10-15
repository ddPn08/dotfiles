{
  nixpkgs,
  home-manager,
  neovim-nightly-overlay,
  tuicr,
  ...
}:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  defaultUsername = "ddpn08";
  envUsername = builtins.getEnv "PORTABLE_USERNAME";
  username =
    if envUsername != "" then envUsername else defaultUsername;
  envHome = builtins.getEnv "PORTABLE_HOME";
  home-dir =
    if envHome != "" then envHome else "/home/${username}";
in
{
  portable = home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    extraSpecialArgs = {
      inherit
        system
        username
        home-dir
        nixpkgs
        neovim-nightly-overlay
        ;
    };
    modules = [
      ({ pkgs, ... }: {
        home.username = username;
        home.homeDirectory = home-dir;
        # Make mise tools available to non-interactive SSH commands as well.
        home.sessionPath = [ "${home-dir}/.local/share/mise/shims" ];

        targets.genericLinux.enable = true;
        nix.package = pkgs.nix;
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # Keep keys imported on the host across Home Manager activations.
        programs.gpg.mutableKeys = lib.mkForce true;
        programs.gpg.mutableTrust = lib.mkForce true;

        # Non-login SSH commands do not read /etc/profile.d/nix.sh.
        programs.zsh.envExtra = ''
          if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
            . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          fi
        '';
      })
      ({ config, lib, ... }:
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
        }
      )
    ];
  };
}
