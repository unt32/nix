{ username, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      "preload" = "/home/${username}/nix/images/wallpaper.jpg";
      "wallpaper" = ",/home/${username}/nix/images/wallpaper.jpg";
    };
  };
}