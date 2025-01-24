{
  programs.nushell = {
    extraEnv = ''
      # proto
      let proto_home = $"($env.HOME)/.proto"
      path add ($proto_home | path join "shims")
      path add ($proto_home | path join "bin")
      path add ($proto_home | path join "tools/node/globals/bin")

      $env.PROTO_HOME = $proto_home
    '';
  };
}
