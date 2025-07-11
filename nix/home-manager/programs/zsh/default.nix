{
  programs.zsh = {
    enable = true;
    initContent = ''
      # pnpm
      export PNPM_HOME="$HOME/.local/share/pnpm"   # macOS では "$HOME/Library/pnpm"
      export PATH="$PNPM_HOME:$PATH"
      # pnpm end
    '';
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestion = {
      enable = true;
    };
  };
}
