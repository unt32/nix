
{ config, lanzaboote, lib, pkgs, unstable, ... }:
{
  imports =
  [	
	./hardware-configuration.nix
        lanzaboote.nixosModules.lanzaboote
  ];
  
  environment = { 
    sessionVariables = {
        MOZ_USE_XINPUT2 = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
    };
    systemPackages = with pkgs; [
      sbctl
      tpm2-tss
      tpm2-tools
    ];
  };

  zramSwap.enable = true;
  
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    initrd = {
      luks.devices."luks-c81b66c2-27a8-40fc-b741-2d8c3e39e5bf".device = "/dev/disk/by-uuid/c81b66c2-27a8-40fc-b741-2d8c3e39e5bf";
      systemd.enable = true;
    };
  };

  systemd.services.setMicMuteLed = {
    description = "Set micmute LED brightness";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'echo 0 | ${pkgs.coreutils}/bin/tee /sys/class/leds/platform::micmute/brightness'";
    };
  };

  hardware.bluetooth = {
	enable = true;
	powerOnBoot = false;
        settings.General = {
            experimental = true; # show battery

            # https://www.reddit.com/r/NixOS/comments/1ch5d2p/comment/lkbabax/
            # for pairing bluetooth controller
            Privacy = "device";
            JustWorksRepairing = "always";
            Class = "0x000100";
            FastConnectable = true;
            Enable = "Source,Sink,Media,Socket";
          };
  };

  security.rtkit.enable = true;
	    
  powerManagement = {
	enable = true;
  };

  services = {

   pipewire = {
              enable = true;
              alsa.enable = true;
              alsa.support32Bit = true;
              pulse.enable = true;
              # If you want to use JACK applications, uncomment this
              #jack.enable = true;
              wireplumber = {
                configPackages = [
                  (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/11-bluetooth-policy.conf" ''
                    wireplumber.settings = { bluetooth.autoswitch-to-headset-profile = false }
                  '')
                ];
            };
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
  };

  programs.steam = {
	  enable = true;
          gamescopeSession.enable = true;
	  remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
	  dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
	  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  	
}
