{ config, pkgs, hostname, stateVersion, user, scripts, ... }:
let
  hosts = {
    P16G2 = {
      fontSize = "14"; 
      pixelSize = "35";
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
      LANGUAGE =  "en_US.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
    picom = {
      enable = true;
      settings = {
        unredir-if-possible = true;
      };
    };

    xserver = {
      enable = true;
      xkb = {
        layout = "us,ru";
        variant = "";
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
      scripts.powermenu

      (dwm.overrideAttrs (oldAttrs: rec {
        patches = oldAttrs.patches ++ [
          (fetchpatch {
            url = "https://dwm.suckless.org/patches/noborder/dwm-noborder-6.2.diff";
            sha256 = "sha256-HJKvYCPDgAcxCmKeqA1Fri94RB184odEBF4ZTj6jvy8=";
          })

          ../src/dwm.diff

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
        patches = [
                (fetchpatch {
                  url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
                  sha256 = "sha256-yx9VSwmPACx3EN3CAdQkxeoJKJxQ6ziC9tpBcoWuWHc=";
                })           

                (fetchpatch {
                  url = "https://st.suckless.org/patches/alpha/st-alpha-osc11-20220222-0.8.5.diff";
                  sha256 = "sha256-Y8GDatq/1W86GKPJWzggQB7O85hXS0SJRva2atQ3upw=";
                })           

                ../src/st.diff
      
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
