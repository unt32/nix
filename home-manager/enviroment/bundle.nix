{ pkgs, unstable-pkgs, ... }: {

  home.packages = with pkgs; [
    
    # Clipboard
    cliphist
    wl-clipboard

    # wireless GUI control
	  blueman
	  networkmanagerapplet

    # sound GUI control
    pavucontrol 

    wineWowPackages.waylandFull

    unstable-pkgs.airshipper

    onlyoffice-bin

    atlauncher
    jre8
  ];

  imports = [
    ./hypr/bundle.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
    ./cursor.nix
    ./gtk.nix
    ./qt.nix
    ./dunst.nix
  ];
}