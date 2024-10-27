{ pkgs, username, ... }: {
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

   services.greetd = {
    enable = true;
    settings = rec {
      default_session = {
        #command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd hyprland";
        command = "hyprland";
        user = "${username}";
      };
    };
  };
}