{ lib, pkgs }:
let
  # tmux 3.7c requires jemalloc on macOS to avoid the system calloc bug
  # that can abort the server while entering copy mode.
  tmux_3_7c = pkgs.tmux.overrideAttrs (old: {
    version = "3.7c";
    src = pkgs.fetchFromGitHub {
      owner = "tmux";
      repo = "tmux";
      tag = "3.7c";
      hash = "sha256-TpZXTeXKQv6MV1vAPu5MIT52d3Pl6dYcOReZa7QANZY=";
    };
    buildInputs = old.buildInputs ++ lib.optional pkgs.stdenv.isDarwin pkgs.jemalloc;
    configureFlags = old.configureFlags ++ lib.optional pkgs.stdenv.isDarwin "--enable-jemalloc";
  });

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
    package = tmux_3_7c;
    terminal = "xterm-256color";
    baseIndex = 0;
    prefix = "C-p";
    sensibleOnTop = false;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [ sensible ] ++ [ tmux-powerline ];
    extraConfig = ''
      set -g extended-keys on
      set -g renumber-windows on
      set -g pane-active-border-style "fg=#8da101,bold"
      set -g pane-border-style "fg=#829181"
      set -g mode-style "fg=#5c6a72,bg=#e1e4bd"
      set -g extended-keys-format csi-u
      set -g allow-passthrough on

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

      # Vim-like copy mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle

      bind-key V \
        select-pane -m \; \
        split-window -h -d \; \
        split-window -h -d -t '{right}' \; \
        select-layout even-horizontal \; \
        copy-mode -u -s '{marked}' -t '{right-of}' \; \
        copy-mode -u -s '{marked}' -t '{right}' \; \
        send-keys -X -t '{right}' page-up \; \
        select-pane -M
    '';
  };
}
