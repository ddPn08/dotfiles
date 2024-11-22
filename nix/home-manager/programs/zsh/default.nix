{ stdenv }:{
  programs.zsh = {
    enable = stdenv.isDarwin;
    initExtra = ''
      export PATH="/etc/profiles/per-user/$USER/bin:$HOME/bin:$PATH"

      if [[ "$VSCODE_RESOLVING_ENVIRONMENT" == 1 ]] || [ -n "$NO_NUSHELL" ] || [[ $- != *i* ]]; then
        return
      fi

      exec nu
    '';
    envExtra = ''
      . "$HOME/.cargo/env"
    ''; 
  };
}
