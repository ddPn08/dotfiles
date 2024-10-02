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
      "figma"
      "gimp"
      "google-chrome"
      "maccy"
      "motrix"
      "mysqlworkbench"
      "notion"
      "obs"
      "postman"
      "rectangle"
      "shottr"
      "slack"
      "tailscale"
      "visual-studio-code"
      "wezterm@nightly"
    ];
    masApps = { };
  };
}
