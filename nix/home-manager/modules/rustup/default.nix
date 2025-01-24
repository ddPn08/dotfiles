{
  programs.zsh = {
    envExtra = ''
      export PATH="$HOME/.cargo/bin:$PATH"
    '';
  };

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
