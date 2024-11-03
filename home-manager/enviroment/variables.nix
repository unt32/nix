{
  home = {
    sessionVariables = {
      

      NIXOS_OZONE_WL = "1";


      # GUI toolkit settings
      QT_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland"; # needs   libsForQt5.qt5.qtwayland
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      CLUTTER_BACKEND = "wayland";

      # Video and graphics
      MOZ_ENABLE_WAYLAND = "1";
      SDL_VIDEODRIVER = "wayland";
      #WLR_RENDERER = "vulkan";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
      WLR_NO_HARDWARE_CURSORS = "1"; # if no cursor,uncomment this line

      # Java GUI settings
      #_JAVA_AWT_WM_NONREPARENTING = "1";

      # Desktop environment settings
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_XDG_OPEN_USE_PORTAL = "1";

      # File path settings
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      #XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/usr/local/share";
    };
  };
}