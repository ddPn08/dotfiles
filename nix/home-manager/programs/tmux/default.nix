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
    prefix = "C-p";
    sensibleOnTop = false;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [ sensible ] ++ [ tmux-powerline ];
    extraConfig = ''
      set -g pane-active-border-style fg=cyan,bold
      set -g pane-border-style fg=colour240

      # Vim-like pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Vim-like pane resizing
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Vim-like split
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Vim-like copy mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
    '';
  };
}
