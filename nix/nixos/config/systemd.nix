{ isWsl, ... }:
{
  systemd.services = {
    "auto-fix-vscode-server".enable = !isWsl;
  };
}
