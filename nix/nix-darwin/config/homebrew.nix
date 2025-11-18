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
      "drawio"
      "figma"
      "gimp"
      "google-chrome"
      "linear-linear"
      "maccy"
      "macfuse"
      "motrix"
      "mysqlworkbench"
      "notion"
      "obs"
      "pgadmin4"
      "postman"
      "readdle-spark"
      "rectangle"
      "shottr"
      "slack"
      "steam"
      "tailscale-app"
      "visual-studio-code"
      "wezterm@nightly"
      "xcodes"
      "zen"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Amazon Prime Video" = 545519333;
    };
  };
}
