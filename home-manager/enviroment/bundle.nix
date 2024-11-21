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
  ];

  imports = [
    ./variables.nix
    ./hypr/bundle.nix
    ./waybar.nix
    ./wlogout.nix
    ./wofi.nix
    ./cursor.nix
    ./gtk.nix
    #./qt.nix
    ./dunst.nix
    #./swaync.nix
  ];
}