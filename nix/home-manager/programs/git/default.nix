{
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [ ".DS_Store" ];

    settings = {
      core = {
        editor = "nvim";
        quotepath = "off";
        ignorecase = false;
        safecrlf = true;
        autocrlf = false;
        precomposeunicode = true;
        untrackedCache = true;
        fsmonitor = true;
      };

      commit = {
        template = "~/.config/git/message";
        gpgsign = true;
      };

      tag = {
        gpgsign = true;
      };

      user = {
        name = "ddpn08";
        email = "pyn.g.1125@gmail.com";
        signingkey = "2B6123530BF43B16";
      };

      pull = {
        ff = "only";
      };

      github = {
        user = "ddpn08";
      };

      gpg = {
        program = "gpg";
      };

      diff = {
        patience = true;
      };

      url = {
        "git@github.com:".insteadOf = "https://github.com/";
      };

      init = {
        defaultBranch = "main";
      };
    };
  };
}
