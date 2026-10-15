{
  lib,
  config,
  pkgs,
  neovim-nightly-overlay,
}:
let
  aria2 = import ./aria2;
  bash = import ./bash;
  btop = import ./btop;
  codex = import ./codex;
  direnv = import ./direnv;
  fzf = import ./fzf;
  gh = import ./gh;
  git = import ./git;
  gnupg = import ./gnupg;
  k9s = import ./k9s;
  lazygit = import ./lazygit;
  nvim = import ./neovim { inherit pkgs neovim-nightly-overlay; };
  pi-coding-agent = import ./pi-coding-agent { inherit pkgs; };
  ripgrep = import ./ripgrep;
  starship = import ./starship;
  tmux = import ./tmux { inherit lib pkgs; };
  uv = import ./uv;
  yt-dlp = import ./yt-dlp;
  zsh = import ./zsh;
in
[
  aria2
  bash
  btop
  codex
  direnv
  fzf
  gh
  git
  gnupg
  k9s
  lazygit
  nvim
  pi-coding-agent
  ripgrep
  starship
  tmux
  uv
  yt-dlp
  zsh
]
