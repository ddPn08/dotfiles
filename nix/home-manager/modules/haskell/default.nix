{
  programs.nushell = {
    extraEnv = ''
      # haskell
      let ghcup_home = $"($env.HOME)/.ghcup"
      let cabal_home = $"($env.HOME)/.cabal"
      let stack_home = $"($env.HOME)/.stack"

      path add ($ghcup_home | path join "bin")
      path add ($cabal_home | path join "bin")
      path add ($stack_home | path join "bin")
    '';
  };
}
