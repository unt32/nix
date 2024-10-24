{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  
  }; 

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  
  environment.systemPackages = with pkgs; [
    # wayland 
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xwayland
    wayland-protocols
    wayland-utils
    wlroots
  ];
}