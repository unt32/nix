#let 
#  filePickers = ["xdg-desktop-portal-gtk" "File Upload" "Open File"];
#in
{ 
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      #monitor = ",preferred,auto,1";
      #monitor = "LDVS-1,1366x768@60,0x0,1";
      monitor = "eDP-1,3840x2400@60,0x0,2.5";

      exec-once = [
        
        "hyprlock"

        "waybar"

        "cliphist wipe"
        "wl-paste --watch cliphist store"


        "nm-applet --indicator"  

        "rfkill unblock bluetooth"
        "rfkill toggle bluetooth"     # toggle off
        #"blueman-applet"
        "[workspace special silent] blueman-manager"  
        "[workspace special silent] pavucontrol"          

        "[workspace 1 silent] firefox"
        "[workspace 3 silent] foot"

        "hyprctl dispatch workspace 2"
        "code"
      ];

      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      input = {
        kb_layout = "us,ru";
        kb_variant = "lang";
        #kb_options = "grp:ctrl_shift_toggle";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        no_border_on_floating = false;
        allow_tearing = false;
        
        border_size = 1;
        gaps_in = 5;
        gaps_out = 5;
        
        "col.active_border" = "rgb(a7add4)";
        "col.inactive_border" = "rgb(282a36)";
        "col.nogroup_border" = "rgb(282a36)";
        "col.nogroup_border_active" = "rgb(44475a)";
      };

      decoration = {
        rounding = 5;

        # Change transparency of focused and unfocused windows
        "active_opacity" = "1.0";
        "inactive_opacity" = "1.0";

        "col.shadow" = "rgba(1E202966)";

        # suggested shadow setting
        drop_shadow = true;
        shadow_range = 60;
        "shadow_offset" = "1 2";
        shadow_render_power = 3;
        shadow_scale = 0.97;
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        # bezier = "myBezier, 0.33, 0.82, 0.9, -0.08";

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # you probably want this
      };

      master = {
        "new_status" = "master";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_invert = true;
        workspace_swipe_distance = 200;
        workspace_swipe_forever = true;
      };

      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = true;
        render_ahead_of_time = false;
        disable_hyprland_logo = true;
      };

     # xwayland = {
     #   force_zero_scaling = true;
     # };

      windowrule = [
        "float, ^(pavucontrol)$"
        "workspace special, ^(pavucontrol)$"
        "move 1% 7%, ^(pavucontrol)$"
        "size 40% 85%, ^(pavucontrol)$"
        "opacity 0.9, ^(pavucontrol)$"

        "float, ^(.blueman-manager-wrapped)$"
        "workspace special, ^(.blueman-manager-wrapped)$"
        "move 59% 7%, ^(.blueman-manager-wrapped)$"
        "size 40% 85%, ^(.blueman-manager-wrapped)$"
        "opacity 0.9, ^(.blueman-manager-wrapped)$"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"

        "bordercolor rgb(d6adad), xwayland:1" # check if window is xwayland

        # File pickers
        "float, title:^(xdg-desktop-portal-gtk)$"
        "move 1% 7%, title:^(xdg-desktop-portal-gtk)$"
        "size 60% 85%, title:^(xdg-desktop-portal-gtk)$"
        "opacity 0.9, title:^(xdg-desktop-portal-gtk)$"

        "opacity 0.9, title: ^(File Upload)$"
        "move 1% 7%, title:^(File Upload)$"
        "size 60% 85%, title:^(File Upload)$"

        "opacity 0.9, title:^(Open File)$"
        "move 1% 7%, title:^(Open File)$"
        "size 60% 85%, title:^(Open File)$"


        "opacity 0.9, title:^(Open file)$"
        "move 1% 7%, title:^(Open file)$"
        "size 60% 85%, title:^(Open file)$"

        "opacity 0.9, title:^(Enter name of file to save to…)$"
        "move 1% 7%, title:^(Enter name of file to save to…)$"
        "size 60% 85%, title:^(Enter name of file to save to…)$"



        "opacity 0.98, initialTitle:^(Visual Studio Code)$"

        "opacity 0.9, class:^(nm-applet)$"

        "opacity 0.9, class:^(polkit-gnome-authentication-agent-1)$"

        "opacity 0.9, class:^(org.gnome.Nautilus)$"

        "opacity 0.9, class:^(lutris)$"

        "opacity 0.9, class:^(com-atlauncher-App)$"


        "opacity 0.9, class:^(steam)$"
        "float,initialTitle:^(Steam Settings)$"
        "move 100 37,initialTitle:^(Steam Settings)$"
        "size 960 720,initialTitle:^(Steam Settings)$"

        "opacity 0.9, class:^(WebCord)$"
      ];
    
      bind = [

        "$mainMod, Q, exec, foot"
        "ALT, F4, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, exec, wlogout"
        "$mainMod, L, exec, loginctl lock-session"
        "$mainMod, F1, exec, ~/.config/hypr/gameMode.sh"
        "$mainMod, Backspace, exec, cliphist list | wofi -S dmenu -w 1 | cliphist decode | wl-copy"

        # Printscreen
        ", Print, exec, hyprshot --clipboard-only -m region"
        "$mainMod, Print, exec, hyprshot --clipboard-only -m output"

        
        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
        "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
        "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
        "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
        "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
        "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
        "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
        "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
        "$mainMod SHIFT, 9, movetoworkspacesilent, 9"
        "$mainMod SHIFT, 0, movetoworkspacesilent, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Special workspace
        "$mainMod, S, togglespecialworkspace"
        "$mainMod SHIFT, S, movetoworkspace, special"

        # Move focus with mainMod + arrow keys
        "$mainMod, left,  movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up,    movefocus, u"
        "$mainMod, down,  movefocus, d"

        # Moving windows
        "$mainMod SHIFT, left,  swapwindow, l"
        "$mainMod SHIFT, right, swapwindow, r"
        "$mainMod SHIFT, up,    swapwindow, u"
        "$mainMod SHIFT, down,  swapwindow, d"

        # Window resizing                     X  Y
        "$mainMod CTRL, left,  resizeactive, -60 0"
        "$mainMod CTRL, right, resizeactive,  60 0"
        "$mainMod CTRL, up,    resizeactive,  0 -60"
        "$mainMod CTRL, down,  resizeactive,  0  60"

        # Volume control
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness control
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"

        # Waybar
        "$mainMod, B, exec, pkill -SIGUSR1 waybar"
        #"$mainMod, W, exec, pkill -SIGUSR2 waybar"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
