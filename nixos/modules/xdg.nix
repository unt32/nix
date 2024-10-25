{ pkgs, ...}: {
  #save file dialog
  services.dbus.enable = true;
  xdg.portal = {
	  enable = true;
	  wlr.enable = true;
	  extraPortals = [
  		  pkgs.xdg-desktop-portal-hyprland
  		  pkgs.xdg-desktop-portal-gtk
  	];
  };
}