{
  nixpkgs,
  home-manager,
  neovim-nightly-overlay,
  tuicr,
}:
let
  lib = nixpkgs.lib;
  system = "x86_64-linux";
  username = "ddpn08";
  home-dir = "/home/${username}";
in
lib.nixosSystem {
  inherit system;
  modules = [
    "${nixpkgs}/nixos/modules/virtualisation/google-compute-config.nix"
    ../../nixos/config/i18n.nix
    ../../nixos/config/nix.nix
    ../../nixos/config/virtualisation.nix
    (import ../../nixos/config/programs.nix {
      inherit lib;
      pkgs = nixpkgs.legacyPackages.${system};
    })
    home-manager.nixosModules.home-manager
    ({ pkgs, ... }: {
      system.stateVersion = "26.05";
      nixpkgs.config.allowUnfree = true;

      boot.initrd.availableKernelModules = [ "nvme" ];
      boot.loader.timeout = lib.mkForce 5;
      boot.loader.grub = {
        enable = true;
        device = lib.mkForce "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        configurationLimit = lib.mkForce 5;
      };
      fileSystems."/boot" = {
        device = "/dev/disk/by-label/ESP";
        fsType = "vfat";
      };

      networking.hostName = "mitsuhori-workspace";
      networking.useDHCP = true;
      networking.firewall.enable = true;
      networking.firewall.interfaces.eth0.allowedTCPPorts = [ 22 ];
      # This VM uses instance metadata SSH keys rather than Google OS Login.
      security.googleOsLogin.enable = lib.mkForce false;
      services.openssh.openFirewall = false;
      services.openssh.settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
      users.users.${username} = {
        isNormalUser = true;
        linger = true;
        extraGroups = [ "wheel" ];
        shell = pkgs.zsh;
      };

      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        nvidiaSettings = false;
      };
      hardware.nvidia-container-toolkit.enable = true;
      virtualisation.docker.enable = true;

      time.timeZone = "Asia/Tokyo";

      home-manager.useUserPackages = true;
      home-manager.users.${username} =
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
    })
  ];
}
