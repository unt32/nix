{
  services.dunst = {
    enable = true;
    settings = {

      global = {
        frame_color = "#AEAFAF";
        separator_color = "frame";
      };

      urgency_low = {
        background = "#1E2326";
        foreground = "#cad3f5";
      };

      urgency_normal = {
        background = "#272E33";
        foreground = "#cad3f5";
      };

      urgency_critical = {
        background = "#24273a";
        foreground = "#cad3f5";
        frame_color = "#f5a97f";
      };     
    };
  };
}