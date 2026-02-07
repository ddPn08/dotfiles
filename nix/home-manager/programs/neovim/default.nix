{ pkgs, neovim-nightly-overlay }:
{
  xdg.configFile = {
    "nvim/lua/config/lazy.lua".source = ./lua/config/lazy.lua;
    "nvim/lua/config/autocmds.lua".source = ./lua/config/autocmds.lua;
    "nvim/lua/config/keymaps.lua".source = ./lua/config/keymaps.lua;
    "nvim/lua/config/options.lua".source = ./lua/config/options.lua;
    "nvim/lua/plugins/formatting.lua".source = ./lua/plugins/formatting.lua;
    "nvim/lua/plugins/toggleterm.lua".source = ./lua/plugins/toggleterm.lua;
    "nvim/lua/plugins/nix.lua".source = ./lua/plugins/nix.lua;
    "nvim/lua/plugins/diffview.lua".source = ./lua/plugins/diffview.lua;
  };

  programs.neovim = {
    enable = true;
    # Use stable version for better treesitter compatibility
    # To switch back to nightly: neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default
    package = pkgs.neovim-unwrapped;
    withNodeJs = true;
    initLua = builtins.readFile ./init.lua;
  };
}
