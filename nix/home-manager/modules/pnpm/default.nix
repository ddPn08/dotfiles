{
  programs.fish = {
    shellInit = ''
      set -x PNPM_HOME "$HOME/.local/share/pnpm"
      if not contains $PNPM_HOME $PATH
        set -x PATH $PNPM_HOME $PATH
      end
    '';
  };
}
