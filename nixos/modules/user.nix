{
    users.users.unt32 = {
      isNormalUser = true;
      description = "unt32";
      extraGroups = [ "networkmanager" "wheel" ];
   };

   services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "hyprland";
        user = "unt32";
      };
      default_session = initial_session;
    };
  };
}