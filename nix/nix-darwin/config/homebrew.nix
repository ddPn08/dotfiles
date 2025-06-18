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
      "chatgpt"
      "cloudflare-warp"
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
      "zen"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Azookey" = 1542709230;
    };
  };
}
