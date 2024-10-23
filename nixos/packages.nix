{pkgs, pkgs-unstable, ...}: {
  
  nixpkgs.config.allowUnfree = true;

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
    pkgs-unstable.nwg-look #GTK3 settings editor
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