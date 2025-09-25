{
  config,
  pkgs,
  scripts,
  ...
}:
{
  services = {
    dwm-status.enable = true;

    picom = {
      enable = true;
      settings = {
        unredir-if-possible = true;
      };
    };

    displayManager.ly = {
      enable = true;
      settings = {
        load = true;
        save = true;
      };
    };
  };

  programs = {
    i3lock.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      scripts.screen-init
      scripts.status-bar
      scripts.battery
      scripts.plugged
      scripts.powermenu
      scripts.openit

      dwm
      st
      dmenu

      xidlehook
      xss-lock
      xkb-switch
      alsa-utils
      brightnessctl

      xclip
      scrot
    ];
  };
}
