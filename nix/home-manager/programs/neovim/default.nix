{ pkgs, neovim-nightly-overlay }:
{
  xdg.configFile = {
    "nvim/lua/config/lazy.lua".source = ./lua/config/lazy.lua;
    "nvim/lua/config/autocmds.lua".source = ./lua/config/autocmds.lua;
    "nvim/lua/config/keymaps.lua".source = ./lua/config/keymaps.lua;
    "nvim/lua/config/options.lua".source = ./lua/config/options.lua;
  };
  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;

    coc.enable = true;

    extraLuaConfig = builtins.readFile ./init.lua;
  };
}
