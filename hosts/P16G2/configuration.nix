{
  config,
  lanzaboote,
  disko,
  lib,
  pkgs,
  unstable,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./tlp.nix
    ./disko.nix
    lanzaboote.nixosModules.lanzaboote
    disko.nixosModules.disko
  ];

  environment = {
    sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2.2"; # default 1 I think
      GDK_SCALE = "2.5";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      XCURSOR_SIZE = "64"; # default 16 I think
    };
    systemPackages = with pkgs; [
      sbctl
      tpm2-tss
      tpm2-tools
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

    initrd = {
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

  security = {
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true; # expose /run/current-system/sw/lib/libtpm2_pkcs11.so
      tctiEnvironment.enable = true; # TPM2TOOLS_TCTI and TPM2_PKCS11_TCTI env variables
    };
  };

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
      extraConfig.pipewire = {
        "99-my-config" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.min-quantum" = 1024;
          };
        };
      };
      # Configuration for the PipeWire client library
      extraConfig.client = {
        "99-my-client-config" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
          };
        };
      };

    };

    autorandr.profiles = {
      "main" = {
        fingerprint = {
          eDP-1 = "00ffffffffffff004c83654100000000001f0104b5221678020cf1ae523cb9230c50540000000101010101010101010101010101010171df0050f06020902008880058d71000001b71df0050f06020902008880058d71000001b000000fe0053444320202020202020202020000000fe0041544e413630595630342d302001ac02030f00e3058000e606050174600700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b7";
        };
        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2400";
            gamma = "1:1:1";
            rate = "60.00";
            rotate = "normal";
          };
        };
      };
    };

    xserver = {
      upscaleDefaultCursor = true;
      dpi = 240;
    };

    dwm-status = {
      extraConfig = builtins.readFile ./dwm-status.toml;
      order = [
        "audio"
        "backlight"
        "battery"
        "network"
        "time"
      ];
    };

    logind = {
      lidSwitch = "suspend";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "suspend";
    };

    fprintd = {
      enable = true;
      package = pkgs.fprintd-tod;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;

      };
    };

    touchegg.enable = true;
    blueman.enable = true;
  };

}
