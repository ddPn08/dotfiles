{

  programs.nushell = {
    extraEnv = ''
      # python virtual env
      $env.VIRTUAL_ENV_DISABLE_PROMPT = true
    '';
  };
}
