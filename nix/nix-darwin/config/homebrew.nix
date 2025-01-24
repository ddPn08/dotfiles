{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    brews = [
      "ghcup"
    ];
    casks = [
      "android-studio"
      "arc"
      "asana"
      "audacity"
      "cursor"
      "discord"
      "docker"
      "figma"
      "gimp"
      "google-chrome"
      "maccy"
      "macfuse"
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
      "zen-browser"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };
}
