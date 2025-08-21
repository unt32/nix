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

      SCREEN = "--output eDP-1 --primary --mode 3840x2400 --rotate normal --refresh 60";
      idle = "battery";

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
      timeout = 0;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    initrd = {
      systemd.enable = true;
      verbose = false;
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
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

    xserver = {
      upscaleDefaultCursor = true;
      dpi = 192;
    };

    dwm-status = {
      enable = true;
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
    #enable = true;
    #gamescopeSession.enable = true;
    remotePlay.openFirewall = false; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

}
