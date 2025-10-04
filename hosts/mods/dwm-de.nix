{
  config,
  pkgs,
  lib,
  hostname,
  user,
  scripts,
  ...
}:
let
  hosts = {
    P16G2 = {
      idle = "battery";
    };
  };

  default = {
    idle = "plugged";
  };

  host = if builtins.hasAttr hostname hosts then hosts.${hostname} else default;
in
{
  services = {
    dwm-status.enable = true;

    xserver.windowManager.dwm.enable = true;

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

    autorandr.enable = true;
  };

  systemd.user.services = {
    dwm-status.serviceConfig = {
      ExecStartPre = "${pkgs.alsa-utils}/bin/amixer sget Master";
      Restart = "on-failure";
      RestartSec = 5;
    };

    dwm-locker = {
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.bash}/bin/bash -c '${pkgs.xkb-switch}/bin/xkb-switch -s us & ${pkgs.i3lock}/bin/i3lock -kc 000000' ";
      };
    };

    dwm-idle = {
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      environment = {
        PATH = lib.mkForce "${pkgs.xorg.xset}/bin:${pkgs.xorg.xrandr}/bin:${pkgs.gawk}/bin:${pkgs.xidlehook}/bin:${pkgs.coreutils}/bin:";
      };
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "${scripts.${host.idle}}/bin/${host.idle}";
      };
    };

    dwm-wallpaper = {
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        Restart = "on-failure";
        RestartSec = 5;
        ExecStart = "${pkgs.bash}/bin/bash -c \"/home/${user}/.fehbg && echo 'Custom wallpaper applied' || ${pkgs.feh}/bin/feh --no-fehbg --bg-fill ${../../src/wallpaper.jpg}\"";
      };
    };

  };

  programs = {
    i3lock.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
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
