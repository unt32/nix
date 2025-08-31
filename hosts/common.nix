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
      borderPx = "4";
      alpha = "0.8";
      pixelSize = "40";
    };
  };

  default = {
    fontSize = "14";
    borderPx = "2";
    alpha = "0.9";
    pixelSize = "16";
  };

  host = if builtins.hasAttr hostname hosts then hosts.${hostname} else default;
in
{

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (import ../src/overlays/dwm.nix {
        inherit (host)
          fontSize
          borderPx
          ;
      })

      (import ../src/overlays/st.nix {
        inherit (host)
          alpha
          pixelSize
          ;
      })
    ];
  };

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

    openssh = {
      enable = true;
      ports = [ 39651 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "unt32" ];
      };

    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "45b6e887e2bc151f"
      ];
    };
  };

  programs = {
    i3lock.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
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
