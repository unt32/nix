{ config, pkgs, hostname, stateVersion, fontSize, pixelSize, user, ... }:
{
  system.stateVersion = stateVersion;
  
  networking.networkmanager.enable = true;
  networking.hostName = hostname;

  # Set your time zone.
  time.timeZone = "Europe/Chisinau";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  i18n.extraLocaleSettings = {
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

  security.wrappers.slock = {
    source = "${pkgs.slock}/bin/slock";
    owner = "root";
    group = "root";
    setuid = true;
    setgid = true;
  };
	
  environment.systemPackages = with pkgs; [
    home-manager
    slock

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
    #xautolock
    xidlehook
    xss-lock
    xkb-switch
    alsa-utils
    brightnessctl

    xclip
    scrot

    feh

  ];
  
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
