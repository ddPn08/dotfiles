{
  programs.fish = {
    shellInit = ''
      proto activate fish --export | source
    '';
  };
}
