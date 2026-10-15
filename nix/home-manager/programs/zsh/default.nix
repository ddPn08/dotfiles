{ config, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      share = false;
    };
    initContent = ''
      setopt INC_APPEND_HISTORY
    '';
    profileExtra = ''
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :
    '';
    syntaxHighlighting = {
      enable = true;
    };
    autosuggestion = {
      enable = true;
    };
  };
}
