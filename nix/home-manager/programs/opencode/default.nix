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
        lsp = "allow";
        webfetch = "allow";
        websearch = "allow";
        codesearch = "allow";
        # Context7 MCP (ドキュメント検索)
        "context7_*" = "allow";
        "todo*" = "allow";
        bash = {
          "*" = "ask";
          # 読み取り系コマンド
          "ls *" = "allow";
          "cat *" = "allow";
          "head *" = "allow";
          "tail *" = "allow";
          "less *" = "allow";
          "file *" = "allow";
          "wc *" = "allow";
          "find *" = "allow";
          "grep *" = "allow";
          "rg *" = "allow";
          "tree *" = "allow";
          "stat *" = "allow";
          "du *" = "allow";
          "df *" = "allow";
          # git読み取り系
          "git status*" = "allow";
          "git log*" = "allow";
          "git diff*" = "allow";
          "git show*" = "allow";
          "git branch*" = "allow";
          "git remote*" = "allow";
          "git stash list*" = "allow";
          # パッケージマネージャ情報系
          "npm list*" = "allow";
          "npm ls*" = "allow";
          "pnpm list*" = "allow";
          "yarn list*" = "allow";
          "cargo tree*" = "allow";
          "pip list*" = "allow";
          "pip show*" = "allow";
          # 環境情報
          "which *" = "allow";
          "whereis *" = "allow";
          "type *" = "allow";
          "env" = "allow";
          "printenv*" = "allow";
          "pwd" = "allow";
          "whoami" = "allow";
          "uname *" = "allow";
        };
      };
    };
  };
}
