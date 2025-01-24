{
  programs.nushell = {
    extraEnv = ''
      # kubernetes
      $env.KUBECONFIG = $env.HOME | path join ".kube/config"
    '';
  };
}
