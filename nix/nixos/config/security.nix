{ username }:
{
  security = {
    sudo.extraConfig = ''
      ${username} ALL=NOPASSWD: ALL
    '';
  };
}
