{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  
  }; 

  #environment.sessionVariables ={
  #  NIXOS_OZONE_WL = "1"; # hint electron apps to use wayland
  #  MOZ_ENABLE_WAYLAND = "1"; # ensure enable wayland for Firefox
  #  WLR_RENDERER_ALLOW_SOFTWARE = "1"; # enable software rendering for wlroots
  #  WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors for wlroots
  #  NIXOS_XDG_OPEN_USE_PORTAL = "1"; # needed to open apps after web login
  #};
  
  environment.systemPackages = with pkgs; [
    # wayland 
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    wayland-protocols
    wayland-utils
    wlroots

    wireplumber
  ];
}