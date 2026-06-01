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
      "ios-deploy"
    ];
    casks = [
      "android-studio"
      "arc"
      "antigravity"
      "asana"
      "audacity"
      "chatgpt"
      "cloudflare-warp"
      "codex-app"
      "cursor"
      "discord"
      "drawio"
      "figma"
      "gimp"
      "google-chrome"
      "linear-linear"
      "maccy"
      "macfuse"
      "motrix"
      "mysqlworkbench"
      "nani"
      "notion"
      "osu"
      "obs"
      "obsidian"
      "orbstack"
      "pgadmin4"
      "postman"
      "prismlauncher"
      "readdle-spark"
      "rectangle"
      "shottr"
      "slack"
      "steam"
      "tailscale-app"
      "visual-studio-code"
      "wezterm@nightly"
      "xcodes-app"
      "zen"
      "zoom"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Amazon Prime Video" = 545519333;
      "Amazon Kindle" = 302584613;
      "RunCat" = 1429033973;
    };
  };
}
