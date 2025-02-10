{ config, pkgs, hostname, stateVersion, ... }:
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
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
  };
	
  services.libinput.mouse = {
	middleEmulation = false;
  };
}
