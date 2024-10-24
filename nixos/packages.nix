{pkgs, pkgs-unstable, ...}: {
  
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };

  environment.systemPackages = with pkgs; [
    home-manager

    brightnessctl

    wget
	  git

    mc

    # app launcher
    wofi
    cliphist
    wofi-emoji

    # wireless
	  blueman
	  networkmanagerapplet	

    # sound
    wireplumber
    pipewire 
    pavucontrol 

    # hyprland
	  hyprland
    hyprpaper
	  hyprshot
	  hypridle
    hyprlock
	  hyprpicker
	  hyprcursor

    # wayland 
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots
    wlogout
    
    cliphist


    gtk3
    gtk4
    gnome.nautilus
    polkit_gnome
    gnome.gnome-calculator
    #pkgs-unstable.nwg-look #GTK3 settings editor

    #polkit

    #libsForQt5.polkit-kde-agent
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}