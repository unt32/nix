{
  config,
  pkgs,
  ...
}:
{
  environment = {
    sessionVariables = {
      GDK_SCALE = "1";
    };
  };

  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    power-profiles-daemon.enable = false;
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

  environment = {
    systemPackages = with pkgs; [
      vscode
      gcc
      gdb
    ];
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
