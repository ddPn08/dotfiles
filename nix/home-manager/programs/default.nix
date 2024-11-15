{
  lib,
  pkgs,
  neovim-nightly-overlay,
}:
let
  stdenv = pkgs.stdenv;
  bash = import ./bash { inherit stdenv; };
  btop = import ./btop;
  gh = import ./gh;
  git = import ./git;
  gnupg = import ./gnupg;
  k9s = import ./k9s;
  nvim = import ./neovim { inherit pkgs neovim-nightly-overlay; };
  nushell = import ./nushell;
  starship = import ./starship;
  tmux = import ./tmux { inherit lib pkgs; };
  yt-dlp = import ./yt-dlp;
  zsh = import ./zsh { inherit stdenv; };
in
[
  bash
  btop
  gh
  git
  gnupg
  k9s
  nvim
  nushell
  starship
  tmux
  yt-dlp
  zsh
]
