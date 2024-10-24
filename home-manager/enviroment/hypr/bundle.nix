{ pkgs, ... }: {

  home.packages = with pkgs; [
    hyprshot
    hyprpicker
    hyprcursor
  ];

  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
  ];
}