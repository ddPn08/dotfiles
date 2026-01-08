{
  lib,
  config,
  system,
  nixpkgs,
  neovim-nightly-overlay,
  ...
}:
let
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  packages = import ./packages { inherit lib pkgs; };
  programs = import ./programs {
    inherit
      lib
      config
      pkgs
      neovim-nightly-overlay
      ;
  };
  modules = import ./modules;
in
{
  imports = programs ++ modules;

  xdg.enable = true;

  home = {
    packages = packages;
    sessionVariables = {
      # Not officially in the specification
      XDG_BIN_HOME = "$HOME/.local/bin";
    } // lib.optionalAttrs (pkgs.stdenv.isLinux) {
      XDG_RUNTIME_DIR = "/run/user/$UID";
    } // lib.optionalAttrs (pkgs.stdenv.isDarwin) {
      # Create virtual XDG_RUNTIME_DIR for macOS
      XDG_RUNTIME_DIR = "$HOME/.cache/runtime";
    };
    sessionPath = [
      "$HOME/.local/bin"
    ];
    stateVersion = "25.05";
    activation = lib.mkIf pkgs.stdenv.isDarwin {
      createXdgRuntimeDir = config.lib.dag.entryAfter ["writeBoundary"] ''
        XDG_RUNTIME_DIR="$HOME/.cache/runtime"
        
        # Ensure parent directory exists
        $DRY_RUN_CMD mkdir -p "$(dirname "$XDG_RUNTIME_DIR")"
        
        # Create runtime directory if it doesn't exist
        if [ ! -d "$XDG_RUNTIME_DIR" ]; then
          echo "Creating XDG_RUNTIME_DIR at $XDG_RUNTIME_DIR"
          $DRY_RUN_CMD mkdir -p "$XDG_RUNTIME_DIR"
        fi
        
        # Ensure correct permissions (user-only access)
        $DRY_RUN_CMD chmod 700 "$XDG_RUNTIME_DIR"
        
        # Verify the directory is writable
        if [ -d "$XDG_RUNTIME_DIR" ] && [ ! -w "$XDG_RUNTIME_DIR" ]; then
          echo "Warning: XDG_RUNTIME_DIR ($XDG_RUNTIME_DIR) is not writable"
        fi
      '';
    };
  };

  programs.home-manager.enable = true;
}
