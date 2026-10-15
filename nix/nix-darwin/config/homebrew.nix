{
  environment.systemPath = [
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
      extraFlags = [ "--force-cleanup" ];
    };
    taps = [
      {
        name = "k1LoW/tap";
        trusted = true;
      }
    ];
    brews = [
      "fluid-synth"
      "ghcup"
      "ios-deploy"
      {
        name = "k1LoW/tap/mo";
        trusted = true;
      }
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
      "obs"
      "obsidian"
      "orbstack"
      "osu"
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
      "Amazon Kindle" = 302584613;
      "Amazon Prime Video" = 545519333;
      "Bitwarden" = 1352778147;
      "RunCat Neo" = 6757801838;
    };
  };
}
