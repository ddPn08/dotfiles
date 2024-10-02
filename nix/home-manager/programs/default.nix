{
  lib,
  pkgs,
  neovim-nightly-overlay,
}:
let
  stdenv = pkgs.stdenv;
  bash = import ./bash {inherit stdenv; };
  gh = import ./gh;
  git = import ./git;
  gnupg = import ./gnupg;
  starship = import ./starship;
  nvim = import ./neovim { inherit pkgs neovim-nightly-overlay; };
  nushell = import ./nushell;
  tmux = import ./tmux { inherit lib pkgs; };
  yt-dlp = import ./yt-dlp;
  zsh = import ./zsh { inherit stdenv; };
in
[
  bash
  gh
  git
  gnupg
  starship
  nvim
  nushell
  tmux
  yt-dlp
  zsh
]
