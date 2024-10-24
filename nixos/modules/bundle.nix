{
  imports = [
    ./bootloader.nix
    ./user.nix
    ./sound.nix
    ./network.nix
    ./bluetooth.nix
    ./xdg.nix
    #./xserver.nix
    ./collect-garbage.nix
    ./polkit.nix
    ./hyprland.nix
  ];
}