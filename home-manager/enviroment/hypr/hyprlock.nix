{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        hide_cursor = true;
        ignore_empty_input = true;
        grace = 0;
        disable_loading_bar = true;
      };

      background = [ 
        {
          monitor = "";
          path = "/home/unt32/nix/.icons/wallpaper.jpg";
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # LAYOUT
      label = [
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgba(255, 255, 255, .65)";
          font_size = 12;
          font_family = "SF Pro Display Bold";
          position = "10, 10";
          halign = "left";
          valign = "bottom";
        }
      ];

      # TIME
      label = [
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
          color = "rgba(255, 255, 255, .65)";
          font_size = 30;
          font_family = "SF Pro Display Bold";
          position = "-10, -20 ";
          halign = "right";
          valign = "bottom";
        }
      ];

      # DATE
      label =  [
        {
          monitor = "";
          text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
          color = "rgba(255, 255, 255, .65)";
          font_size = 15;
          font_family = "SF Pro Display Bold";
          position = "-10, -15";
          halign = "right";
          valign = "bottom";
        }
      ];

      # Profie-Photo
      image = [
        {
          monitor = "";
          path = "/home/unt32/nix/.icons/ava.png";
          border_size = 2;
          border_color = "rgba(255, 255, 255, .65)";
          size = 130;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = ;
          position = "0, 40";
          halign = "center";
          valign = "center";
        }
      ];

      # INPUT FIELD
      input-field = [
        {
            monitor = "";
            size = "300, 60";
            outline_thickness = 2;
            dots_size = 0.05; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            outer_color = "rgba(0, 0, 0, 0)";
            inner_color = "rgba(255, 255, 255, 0.1)";
            font_color = "rgb(200, 200, 200)";
            fade_on_empty = false;
            font_family = "SF Pro Display Bold";
            placeholder_text = ''<i><span foreground="##ffffff99">    $USER</span></i>'';
            hide_input = false;
            position = "0, -80";
            halign = "center";
            valign = "center";
        }
      ];
    };
  };
}