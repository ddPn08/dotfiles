{ pkgs }:
{
  documentation.doc.enable = false;

  system.tools.darwin-uninstaller.enable = false;

  system = {
    primaryUser = "ddpn08";
    stateVersion = 5;
    defaults = {
      NSGlobalDomain.AppleShowAllExtensions = true;
      finder = {
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        _FXShowPosixPathInTitle = false;
      };
      dock = {
        autohide = true;
        show-recents = false;
        orientation = "right";
      };
    };
  };
}
