{
  programs.nushell = {
    extraEnv = ''
      # python virtual env
      $env.VIRTUAL_ENV_DISABLE_PROMPT = true
    '';
  };
  home.sessionVariables = {
    VIRTUAL_ENV_DISABLE_PROMPT = "true";
  };
}
