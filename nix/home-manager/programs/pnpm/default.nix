{
  programs.pnpm.enable = true;

  xdg.configFile."pnpm/rc".text = ''
    # 公開直後の compromised package を踏みにくくする。1440 = 24h
    minimum-release-age=1440

    # 未レビューの依存 package の preinstall/install/postinstall で失敗させる
    strict-dep-builds=true

    # pnpm run / exec 時に勝手に install されるのを防ぐ
    verify-deps-before-run=error

    # trusted publishing / provenance の格下げを検知
    trust-policy=no-downgrade

    # 直依存は ^ ではなく exact に保存
    save-exact=true

    # store 検証は明示的に有効化
    verify-store-integrity=true
    strict-store-pkg-content-check=true

    # pnpm 本体は Nix で管理するため、packageManager による自動DLを止める
    manage-package-manager-versions=false
  '';

  # グローバルコマンドは残し、pnpm 本体は Nix プロファイルを優先する
  # programs.zsh.initContent = ''
  #   path=("''${(@)path:#$PNPM_HOME/bin}" "$PNPM_HOME/bin")
  # '';
}
