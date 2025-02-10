# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
{
  imports =
    [	
        ../common.nix
	./hardware-configuration.nix
	./tlp.nix
    ];

  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
  };

  security.rtkit.enable = true;
     services.pipewire = {
	  enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	  pulse.enable = true;
	  # If you want to use JACK applications, uncomment this
	  #jack.enable = true;
  };
  
/*  systemd.services.f4-light-off = {
	  description = "Off f4 btn on boot";
	  wantedBy = [ "multi-user.target" ];
	  serviceConfig = {
	    User = "root";
	    ExecStart = "echo 0 | tee /sys/class/leds/platform\:\:micmute/brightness";  
	    Type = "simple";
	  };
  };
*/
  
  powerManagement = {
	enable = true;
#	powerUpCommands = "echo 0 | sudo tee /sys/class/leds/platform::micmute/brightness";
  };

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver =  pkgs.libfprint-2-tod1-goodix;

    };
  };

  services.libinput.touchpad = {
    accelSpeed = "1.0";
    middleEmulation = false;
  };
	
  services.upower = {
  	enable = true;
  };
  
  services.blueman.enable = true; 
  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
	  "monitor.bluez.properties" = {
	      "bluez5.enable-sbc-xq" = true;
	      "bluez5.enable-msbc" = true;
	      "bluez5.enable-hw-volume" = true;
	      "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
	  };
  };
  programs.steam = {
	  enable = true;
	  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
	  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  	
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c81b66c2-27a8-40fc-b741-2d8c3e39e5bf".device = "/dev/disk/by-uuid/c81b66c2-27a8-40fc-b741-2d8c3e39e5bf";
}
