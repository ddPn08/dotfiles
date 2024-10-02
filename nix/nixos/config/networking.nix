{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    enableIPv6 = true;
    # firewall.enable = true;
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
