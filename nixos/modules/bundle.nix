{
  imports = [
    ./bootloader.nix
    ./user.nix
    ./sound.nix
    ./network.nix
    ./bluetooth.nix
    #./xserver.nix
    ./collect-garbage.nix
    ./polkit.nix

    ./xdg.nix
    ./hyprland.nix

    ./steam.nix
  ];
}