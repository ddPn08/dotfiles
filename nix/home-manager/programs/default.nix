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
  gh = import ./gh;
  git = import ./git;
  gnupg = import ./gnupg;
  k9s = import ./k9s;
  lazygit = import ./lazygit;
  nvim = import ./neovim { inherit pkgs neovim-nightly-overlay; };
  nushell = import ./nushell;
  starship = import ./starship;
  tmux = import ./tmux { inherit lib pkgs; };
  yt-dlp = import ./yt-dlp;
  zsh = import ./zsh { inherit stdenv; };
in
[
  aria2
  bash
  btop
  fish
  gh
  git
  gnupg
  k9s
  lazygit
  nvim
  nushell
  starship
  tmux
  yt-dlp
  zsh
]
