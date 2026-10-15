{
  programs.lazygit = {
    enable = true;
    settings = {
      overrideGpg = true;
      gui.theme = {
        lightTheme = true;
        activeBorderColor = [
          "#8da101"
          "bold"
        ];
        inactiveBorderColor = [ "#829181" ];
        searchingActiveBorderColor = [
          "#dfa000"
          "bold"
        ];
        optionsTextColor = [ "#5c6a72" ];
        selectedLineBgColor = [ "#e1e4bd" ];
        inactiveViewSelectedLineBgColor = [ "#eae4ca" ];
        cherryPickedCommitFgColor = [ "#5c6a72" ];
        cherryPickedCommitBgColor = [ "#e5e6c5" ];
        markedBaseCommitFgColor = [ "#5c6a72" ];
        markedBaseCommitBgColor = [ "#f1e4c5" ];
        unstagedChangesColor = [ "#f85552" ];
        defaultFgColor = [ "#5c6a72" ];
      };
    };
  };
}
