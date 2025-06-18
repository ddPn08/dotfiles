{ pkgs, username }:
{
  environment.shells = [ pkgs.zsh ];

  users = {
    knownUsers = [ "${username}" ];
    users.${username} = {
      uid = 501;
      shell = pkgs.zsh;
    };
  };
}
