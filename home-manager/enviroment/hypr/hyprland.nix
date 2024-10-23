{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";

      monitor = ",preferred,auto,1";
      #monitor = ",800x600@30,0x0,1";

      env = [
        "HYPRCURSOR_THEME,Vanilla-DMZ"
        "HYPRCURSOR_SIZE,20"

        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland"
        "CLUTTER_BACKEND,wayland"

        #"LIBGL_ALWAYS_SOFTWARE,true"
        #"MESA_LOADER_DRIVER_OVERRIDE,zink"
        #"GSK_RENDERER,ngl"
      ];

      exec-once = [
        
        "hyprlock"
        "hypridle"
        "hyprpaper"
        #"~/.config/hypr/changeWallpaper.sh"

        "waybar"
        "dunst"

        "cliphist wipe"
        "wl-paste --watch cliphist store"

        "nm-applet --indicator"
        "blueman-applet"
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
        
        "col.active_border" = "rgb(44475a)";
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
        workspace_swipe_invert = false;
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

      windowrule = [
        "float, ^(pavucontrol)$"
        "pin, ^(pavucontrol)$"

        "float, ^(.blueman-manager-wrapped)$"
        "pin, ^(.blueman-manager-wrapped)$"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "bordercolor rgb(FF0000),xwayland:1" # check if window is xwayland
      ];

      bind = [

        "$mainMod, Q, exec, foot"
        "ALT, F4, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, nautilus"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, wofi --show drun"
        "$mainMod, P, exec, wlogout"
        "$mainMod, L, exec, hyprlock"
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
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}