{ stdenv }: {
  programs.bash = {
    enable = stdenv.isLinux;
    initExtra = ''
      export PATH="/etc/profiles/per-user/$USER/bin:$PATH"

      if [[ "$VSCODE_RESOLVING_ENVIRONMENT" == 1 ]] || [ -n "$NO_NUSHELL" ] || [[ $- != *i* ]]; then
        return
      fi

      exec nu
    '';
  };
}