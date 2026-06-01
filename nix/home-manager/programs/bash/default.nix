{
  programs.bash = {
    enable = true;
    initExtra = ''
      export PATH="/etc/profiles/per-user/$USER/bin:$PATH"
    '';
  };
}
