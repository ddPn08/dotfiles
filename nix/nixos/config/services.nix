{
  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
    };

    tailscale.enable = true;
    vscode-server.enable = true;
  };
}
