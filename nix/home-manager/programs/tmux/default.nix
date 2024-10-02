{ lib, pkgs }:
let
  tmux-powerline = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-powerline";
    version = "unstable-2024-09-25";
    rtpFilePath = "main.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "erikw";
      repo = "tmux-powerline";
      rev = "ba893c98eedc3311cc4dca4a21387c59ec4ad5dd";
      sha256 = "sha256-Agn9ZJtqG9he3XhS938cKbQQrFr1JqOyaT/ARHP1MUQ=";
    };
  };
in
{

  xdg.configFile = {
    "tmux-powerline/config.sh".source = ./tmux-powerline/config.sh;
    "tmux-powerline/themes" = {
      source = ./tmux-powerline/themes;
      recursive = true;
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    baseIndex = 0;
    prefix = "C-b";
    sensibleOnTop = false;
    plugins =
      with pkgs.tmuxPlugins;
      [
        sensible
      ]
      ++ [ tmux-powerline ];
    extraConfig = '''';
  };
}
