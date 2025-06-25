{
  programs.fish = {
    shellInit = ''
      proto activate fish --export | source
    '';
  };
  programs.zsh = {
    initContent = ''
      eval "$(proto activate zsh --export)"
    '';
  };
}
