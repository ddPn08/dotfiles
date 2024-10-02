{
  nix = {
    settings.cores = 8;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    optimise.automatic = true;
  };
}
