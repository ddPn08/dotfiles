{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultOptions = [ "--color=light" ];
    colors = {
      fg = "#5c6a72";
      bg = "#f3ead3";
      hl = "#8da101";
      "fg+" = "#5c6a72";
      "bg+" = "#e1e4bd";
      "hl+" = "#8da101";
      info = "#829181";
      prompt = "#8da101";
      pointer = "#8da101";
      marker = "#8da101";
      spinner = "#35a77c";
      header = "#3a94c5";
      border = "#829181";
      label = "#5c6a72";
      query = "#5c6a72";
    };
  };
}
