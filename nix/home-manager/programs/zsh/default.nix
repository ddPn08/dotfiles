{
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="/etc/profiles/per-user/$USER/bin:$HOME/bin:$PATH"
    '';
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestion = {
      enable = true;
    };
  };
}
