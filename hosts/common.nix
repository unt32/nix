{
  config,
  pkgs,
  hostname,
  stateVersion,
  user,
  scripts,
  ...
}:
let
  hosts = {
    P16G2 = {
      fontSize = "14";
      pixelSize = "40";
      borderpx = "4";
      alpha = "0.8";
    };
  };

  default = {
    fontSize = "14";
    pixelSize = "16";
    borderpx = "1";
    alpha = "0.9";
  };

  host = if builtins.hasAttr hostname hosts then hosts.${hostname} else default;
in
{

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = stateVersion;

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    nftables.enable = true;
    hostName = hostname;
  };

  time.timeZone = "Europe/Chisinau";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
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
    fwupd.enable = true;

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

    libinput = {
      mouse = {
        middleEmulation = false;
        accelProfile = "flat";
        accelSpeed = "0";
      };
      touchpad.middleEmulation = false;
    };
  };

  programs = {
    i3lock.enable = true;
  };

  environment = {
    sessionVariables = {
    };
    variables = {
    };
    systemPackages = with pkgs; [
      vim

      home-manager
      (treefmt.withConfig {
        runtimeInputs = [ pkgs.nixfmt-rfc-style ];
        settings = {
          on-unmatched = "info";
          formatter.nixfmt = {
            command = "nixfmt";
            includes = [ "*.nix" ];
          };
        };
      })

      scripts.screen-init
      scripts.status-bar
      scripts.battery
      scripts.plugged
      scripts.powermenu
      scripts.openit

      (dwm.overrideAttrs (oldAttrs: rec {
        patches = oldAttrs.patches ++ [
          (fetchpatch {
            url = "https://dwm.suckless.org/patches/noborder/dwm-noborder-6.2.diff";
            sha256 = "sha256-HJKvYCPDgAcxCmKeqA1Fri94RB184odEBF4ZTj6jvy8=";
          })

          ../src/dwm.diff

          (builtins.toFile "dwm-diffs.patch" ''
            --- a/config.def.h
            +++ b/config.def.h
            @@ -4,1 +4,1 @@
            -static const unsigned int borderpx  = 1;        /* border pixel of windows */
            +static const unsigned int borderpx  = ${host.borderpx};        /* border pixel of windows */
            @@ -10,2 +10,2 @@
            -static const char *fonts[]          = { "monospace:size=10" };
            -static const char dmenufont[]       = "monospace:size=10";
            +static const char *fonts[]          = { "monospace:size=${host.fontSize}" };
            +static const char dmenufont[]       = "monospace:size=${host.fontSize}";
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

          (builtins.toFile "st-diffs.patch" ''
            --- a/config.def.h
            +++ b/config.def.h
            @@ -8,1 +8,1 @@
            -static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
            +static char *font = "Liberation Mono:pixelsize=${host.pixelSize}:antialias=true:autohint=true";
            @@ -97,1 +97,1 @@ char *termname = "st-256color";
            -float alpha = 0.8;
            +float alpha = ${host.alpha};
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

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  users.users.${user} = {
    isNormalUser = true;
    home = "/home/${user}";
    extraGroups = [
      "input"
      "audio"
      "wheel"
      "networkmanager"
      "tss"
      "users"
    ];
    shell = pkgs.bash;
  };

}
