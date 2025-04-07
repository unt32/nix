
{ config, lanzaboote, lib, pkgs, unstable, ... }:
{
  imports =
  [	
	./hardware-configuration.nix
	./tlp.nix
        lanzaboote.nixosModules.lanzaboote
  ];
  
  environment = { 
    sessionVariables = {
        QT_SCALE_FACTOR = "2.5";
        GDK_SCALE = "2.5";
        GDK_DPI_SCALE = "0.5";
        MOZ_USE_XINPUT2 = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
    };
    systemPackages = with pkgs; [
      unstable.sbctl
    ];
  };

  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    initrd.luks.devices."luks-c81b66c2-27a8-40fc-b741-2d8c3e39e5bf".device = "/dev/disk/by-uuid/c81b66c2-27a8-40fc-b741-2d8c3e39e5bf";
  };

  hardware.bluetooth = {
	enable = true;
	powerOnBoot = false;
  };

  security.rtkit.enable = true;
	    
  powerManagement = {
	enable = true;
  };

  services = {
    /*udev = {
      enable = true;
      extraRules = ''
        SUBSYSTEM=="power_supply", ACTION=="change", ENV{POWER_SUPPLY_NAME}=="BAT0", RUN+="${builtins.toString ../../src/battery.sh}"
        SUBSYSTEM=="power_supply", ACTION=="change", ENV{POWER_SUPPLY_NAME}=="AC", RUN+="${builtins.toString ../../src/plugged.sh}""
      '';
    };*/

    pipewire = {
              enable = true;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
              # If you want to use JACK applications, uncomment this
              #jack.enable = true;
    };

    dwm-status = {
      enable = true;
      extraConfig = builtins.readFile ./dwm-status.toml;
      order = [ "audio" "backlight" "battery" "network" "time" ];
    };

    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "lock";
    };

    fprintd = {
        enable = true;
        package = pkgs.fprintd-tod;
        tod = {
          enable = true;
          driver =  pkgs.libfprint-2-tod1-goodix;

        };
    };

    libinput = {
            enable = true;
            touchpad = {
                accelSpeed = "1.0";
            };
    };

    touchegg.enable = true;	
      
    blueman.enable = true; 
    pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
            "monitor.bluez.properties" = {
                "bluez5.enable-sbc-xq" = true;
                "bluez5.enable-msbc" = true;
                "bluez5.enable-hw-volume" = true;
                "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
            };
    };
  };

  programs.steam = {
	  enable = true;
          gamescopeSession.enable = true;
	  remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
	  dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
	  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  	
}
