{ username, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        no_fade_in = false;
        no_fade_out = true;
        hide_cursor = true;
        ignore_empty_input = true;
        grace = 0;
        disable_loading_bar = true;
        enable_fingerprint = true;
      };

      background = [ 
        {
          monitor = "";
          path = "/home/${username}/nix/images/wallpaper.jpg";
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      label = [
        # LAYOUT
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgba(255, 255, 255, .65)";
          font_size = 20;
          font_family = "SF Pro Display Bold";
          position = "10, 10";
          halign = "left";
          valign = "bottom";
        }
      ];

      # Profie-Photo
      image = [
        {
          monitor = "";
          path = "/home/${username}/nix/images/ava.png";
          border_size = 2;
          border_color = "rgba(255, 255, 255, .65)";
          size = 390;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          reload_cmd = "";
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
      ];

      # INPUT FIELD
      input-field = [
        {
            monitor = "";
            size = "900, 180";
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
            position = "0, -240";
            halign = "center";
            valign = "center";
        }
      ];
    };
  };
}