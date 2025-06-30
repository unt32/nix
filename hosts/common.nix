{ config, pkgs, hostname, stateVersion, user, scripts, ... }:
let
  hosts = {
    P16G2 = {
      fontSize = "26"; 
      pixelSize = "34";
    };
  };

  default = {
    fontSize = "14";
    pixelSize = "16";
  };

  fontSizes = if builtins.hasAttr hostname hosts 
           then hosts.${hostname}
           else default;
in
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

  programs = {
    i3lock.enable = true;
  };

  environment = {
    sessionVariables = {
    };
    systemPackages = with pkgs; [
      home-manager

      scripts.screen-init
      scripts.status-bar
      scripts.battery
      scripts.plugged

      (dwm.overrideAttrs (oldAttrs: rec {
        src = ../src/dwm;
        patches = [
          (builtins.toFile "dwm-fontsize.patch" ''
            --- a/config.def.h
            +++ b/config.def.h
            @@ -10,2 +10,2 @@
            -static const char *fonts[]          = { "monospace:size=10" };
            -static const char dmenufont[]       = "monospace:size=10";
            +static const char *fonts[]          = { "monospace:size=${fontSizes.fontSize}" };
            +static const char dmenufont[]       = "monospace:size=${fontSizes.fontSize}";
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
                  +static char *font = "Liberation Mono:pixelsize=${fontSizes.pixelSize}:antialias=true:autohint=true";
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
