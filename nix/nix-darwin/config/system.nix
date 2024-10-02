{ pkgs }:
{
  system = {
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
