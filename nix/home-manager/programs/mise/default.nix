{
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        # Common languages
        bun = "latest";
        node = "24";
        pnpm = "latest";
        uv = "latest";
        rust = "latest";

        # Infra
        helm = "latest";
        k3d = "latest";
        terraform = "latest";
        terragrunt = "latest";
        actionlint = "latest";
        cloud-sql-proxy = "2";
      };
    };
  };
}
