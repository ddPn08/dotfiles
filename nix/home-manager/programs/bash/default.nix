{ stdenv }: {
  programs.bash = {
    enable = stdenv.isLinux;
    initExtra = ''
      export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
    '';
  };
}
