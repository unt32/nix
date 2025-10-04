{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  environment = {
    sessionVariables = {
    };
    systemPackages = with pkgs; [
      sbctl
      tpm2-tss
      tpm2-tools
    ];
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

  security = {
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  services = {
    dwm-status = {
      extraConfig = builtins.readFile ./dwm-status.toml;
      order = [
        "audio"
        "network"
        "time"
      ];
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

    xserver.videoDrivers = [ "nvidia" ];

    autorandr.profiles = {
      "main" = {
        fingerprint = {
           DP-0 = "00ffffffffffff00410c76c2ae8f000002210104a5351e783b5c45a95046aa270e5054bfef00d1c081803168317c4568457c6168617c023a801871382d40582c45000f282100001e000000ff00554b3032333032303336373832000000fc0032344d314e333230305a410a20000000fd0030a5c8c83c010a2020202020200159020327f14c0103051404131f120211903f23090707830100006d1a0000020130a5000000000000d09480a070381e40304035000f282100001a377f808870381440182035000f282100001e866f80a070384040302035000f282100001e00000000000000000000000000000000000000000000000000000000000000000000bd";
        };
        config = {
          DP-0 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2400";
            gamma = "1:1:1";
            rate = "165.00";
            rotate = "normal";
          };
        };
      };
    };

  };

}
