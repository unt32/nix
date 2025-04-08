{ config, pkgs, hostname, stateVersion, fontSize, pixelSize, vdev, resolution, hz, idle, user, ... }:
{
  system.stateVersion = stateVersion;
  
  networking = {
    networkmanager.enable = true;
    hostName = hostname;
  };

  time.timeZone = "Europe/Chisinau";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        variant = "";
        #options = "grp:win_space_toggle";
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


  environment = {
    sessionVariables = {
      vdev = "${vdev}";
      resolution = "${resolution}";
      hz = "${hz}";
      idle = "${idle}";
    };
    systemPackages = with pkgs; [
      home-manager
      i3lock

      (dwm.overrideAttrs (oldAttrs: rec {
        src = ../src/dwm;
        patches = [
          (builtins.toFile "dwm-fontsize.patch" ''
            --- a/config.def.h
            +++ b/config.def.h
            @@ -10,2 +10,2 @@
            -static const char *fonts[]          = { "monospace:size=10" };
            -static const char dmenufont[]       = "monospace:size=10";
            +static const char *fonts[]          = { "monospace:size=${toString fontSize}" };
            +static const char dmenufont[]       = "monospace:size=${toString fontSize}";
          '')
        ];
      }))

      (st.overrideAttrs (oldAttrs: rec {
        src = ../src/st;
        patches = [
                (builtins.toFile "st-fontsize.patch" ''
                  --- a/config.def.h
                  +++ b/config.def.h
                  @@ -8,1 +8,1 @@
                  -static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
                  +static char *font = "Liberation Mono:pixelsize=${toString pixelSize}:antialias=true:autohint=true";
                '')
              ];
      }))

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
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
	
  services.libinput = {
    mouse = {
      middleEmulation = false;
      accelProfile = "flat";
      accelSpeed = "0";
    };
    touchpad.middleEmulation = false;
  };

  users.users.${user} = {
            isNormalUser = true;
            home = "/home/${user}";
            extraGroups = [ "input" "audio" "wheel" "networkmanager" ];
            shell = pkgs.bash;
  };

}
