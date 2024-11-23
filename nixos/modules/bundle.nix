{
  imports = [
    ./bootloader.nix
    ./user.nix
    ./sound.nix
    ./network.nix
    ./bluetooth.nix
    ./collect-garbage.nix
    ./fprintd.nix

    #./auto-cpufreq.nix
    ./tlp.nix
    
    # hyprland stuff
    ./polkit.nix
    ./xdg.nix
    ./hyprland.nix

    ./steam.nix
  ];
}
