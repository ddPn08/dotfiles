{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
      extraFlags = [ "--force-cleanup" ];
    };
    brews = [
      "fluid-synth"
      "ghcup"
      "ios-deploy"
    ];
    casks = [
      "android-studio"
      "arc"
      "asana"
      "audacity"
      "chatgpt"
      "claude"
      "cloudflare-warp"
      "codex-app"
      "cursor"
      "discord"
      "drawio"
      "figma"
      "gimp"
      "google-chrome"
      "gstreamer-runtime"
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
      "wine-stable"
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
