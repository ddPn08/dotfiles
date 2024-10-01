{
  xdg.configFile."nushell/modules/python/conda.nu".source = ./modules/python/conda.nu;
  xdg.configFile."nushell/modules/python/venv.nu".source = ./modules/python/venv.nu;
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
}
