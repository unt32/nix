{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  environment = {
    sessionVariables = {
      SCREEN = "--output DP-0 --mode 1920x1080 --refresh 165 --primary --pos 0x0 --rotate normal";
      idle = "plugged";
    };
  };

  boot = {
      loader = {
        systemd-boot = {
            enable = true;
            memtest86.enable = true;
        };
        efi.canTouchEfiVariables = true;
      };

      extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
      extraModprobeConfig = ''
        options bluetooth disable_ertm=Y
      '';
      # connect xbox controller
  };


  hardware = {
    bluetooth = {
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

    xpadneo.enable = true;

    nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of
      # supported GPUs is at:
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
      # Only available from driver 515.43.04+
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.production;
    };

    graphics = {
      enable = true;
    };

  };

  security.rtkit.enable = true;
  services = {
    dwm-status = {
        enable = true;
        extraConfig = builtins.readFile ./dwm-status.toml;
        order = [ "audio" "network" "time" ];
    };

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
            extraConfig.pipewire = {
              "99-my-config" = {
                "context.properties" = {
                  "default.clock.rate" = 96000;
                  "default.clock.min-quantum" = 1024;
                };
              };
            };
            # Configuration for the PipeWire client library
            extraConfig.client = {
              "99-my-client-config" = {
                "context.properties" = {
                  "default.clock.rate" = 96000;
                };
              };
            };
    };

    blueman.enable = true;
    xserver.videoDrivers = ["nvidia"];
  };

  programs.steam = {
          enable = true;
          gamescopeSession.enable = true;
          remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
          dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
          localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
          extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
}
