{
  lib,
  config,
  pkgs,
  neovim-nightly-overlay,
}:
let
  stdenv = pkgs.stdenv;
  aria2 = import ./aria2;
  bash = import ./bash { inherit stdenv; };
  btop = import ./btop;
  fish = import ./fish;
  fzf = import ./fzf;
  gh = import ./gh;
  git = import ./git;
  gnupg = import ./gnupg;
  k9s = import ./k9s;
  lazygit = import ./lazygit;
  nvim = import ./neovim { inherit pkgs neovim-nightly-overlay; };
  nushell = import ./nushell;
  ripgrep = import ./ripgrep;
  starship = import ./starship;
  tmux = import ./tmux { inherit lib pkgs; };
  yt-dlp = import ./yt-dlp;
  zsh = import ./zsh;
in
[
  aria2
  bash
  btop
  fish
  fzf
  gh
  git
  gnupg
  k9s
  lazygit
  nvim
  nushell
  ripgrep
  starship
  tmux
  yt-dlp
  zsh
]
