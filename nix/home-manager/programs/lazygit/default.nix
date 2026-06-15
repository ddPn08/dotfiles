{
  programs.lazygit = {
    enable = true;
    settings = {
      overrideGpg = true;
      gui.theme = {
        lightTheme = true;
        activeBorderColor = [ "blue" "bold" ];
        inactiveBorderColor = [ "black" ];
        selectedLineBgColor = [ "default" ];
      };
    };
  };
}
