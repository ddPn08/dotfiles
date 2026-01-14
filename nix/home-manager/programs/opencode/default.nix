{
  programs.opencode = {
    enable = true;
    settings = {
      permission = {
        "*" = "ask";
        read = "allow";
        glob = "allow";
        grep = "allow";
        list = "allow";
        webfetch = "allow";
        websearch = "allow";
        codesearch = "allow";
      };
    };
  };
}
