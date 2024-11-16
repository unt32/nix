{
  imports = [
    ./bootloader.nix
    ./user.nix
    ./sound.nix
    ./network.nix
    ./bluetooth.nix
    ./collect-garbage.nix
    
    # hyprland stuff
    ./polkit.nix
    ./xdg.nix
    ./hyprland.nix

    ./steam.nix
  ];
}