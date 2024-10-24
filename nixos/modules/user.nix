{ pkgs, ... }: {
  users.users.unt32 = {
    isNormalUser = true;
    description = "unt32";
    extraGroups = [ "networkmanager" "wheel" ];
  };

   services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
        command = "hyprland";
        user = "unt32";
      };
    };
  };
}