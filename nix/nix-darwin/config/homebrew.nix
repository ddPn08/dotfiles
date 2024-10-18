{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = [
      "android-studio"
      "asana"
      "audacity"
      "discord"
      "docker"
      "figma"
      "gimp"
      "google-chrome"
      "maccy"
      "motrix"
      "mysqlworkbench"
      "notion"
      "obs"
      "postman"
      "readdle-spark"
      "rectangle"
      "shottr"
      "slack"
      "tailscale"
      "visual-studio-code"
      "wezterm@nightly"
      "xcodes"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };
}
