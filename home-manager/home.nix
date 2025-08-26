{
  homeStateVersion,
  user,
  pkgs,
  unstable,
  ...
}:
{

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [

      pavucontrol
      dconf # for GTK
      firefox
      mpv
      feh

      lutris
      wineWowPackages.full

      #prismlauncher
      #jdk21

      jrnl

      powertop
      htop

      # LF
      highlight
      poppler-utils
      bat
      timg

      rtorrent
      curl

      pv
      less
      tree
      file
      blobdrop
      p7zip
      ntfs3g
      simple-mtpfs
    ];

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      OPENER = "openit";
    };
  };

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        alias rs='echo -e "\nrebuild switch\n"; sudo nixos-rebuild switch --flake ~/nix'
        alias rb='echo -e "\nrebuild boot\n"; sudo nixos-rebuild boot --flake ~/nix'
        alias rt='echo -e "\nrebuild test\n"; sudo nixos-rebuild test --flake ~/nix'

        alias hs='echo -e "\nhome-manager switch\n"; home-manager switch --flake ~/nix/'

        alias fwopen='sudo nft add rule inet nixos-fw input tcp dport 1414 accept'
        alias fwlist='sudo nft list ruleset'
        alias fwclose='sudo systemctl restart nftables.service'
      '';
    };

    lf = {
      enable = true;
      previewer = {
        source = pkgs.writeShellScript "preview.sh" ''
          #!/bin/sh

          file "$1"
          case "$1" in
              *.tar*) tar tf "$1";;
              *.7z|*.rar|*.zip) 7z l "$1";;
              *.pdf) pdftotext "$1" -;;
              *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp|*.tiff|*.mp4|*.mov|*.avi) timg -g 80x40 --frames 1 "$1";;
              *) highlight -O xterm256 "$1" || cat "$1";;
          esac
        '';
      };
      keybindings = {
        D = "trash";
        f = "filetype";
      };
      commands = {
        trash = "%mv $fs ~/trash/ || mv $f ~/trash/ ";
        filetype = "%file $f";
      };
      extraConfig = ''
        $mkdir -p ~/trash
      '';
    };

    vim = {
      enable = true;
      extraConfig = ''
        colorscheme torte
        autocmd ColorScheme * hi Normal ctermbg=NONE guibg=NONE
      '';
    };

    git = {
      enable = true;
      userEmail = "vladsaen5@gmail.com";
      userName = "unt32";
    };

    mangohud = {
      enable = true;
      settings = {
        preset = 3;
      };
    };

    vesktop = {
      enable = true;
      settings = {
        appBadge = false;
        arRPC = true;
        checkUpdates = false;
        customTitleBar = false;
        disableMinSize = true;
        minimizeToTray = false;
        tray = false;
        splashBackground = "#000000";
        splashColor = "#ffffff";
        splashTheming = true;
        staticTitle = true;
        hardwareAcceleration = true;
        discordBranch = "stable";
      };
      vencord = {
        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          plugins = {
            MessageLogger = {
              enabled = true;
              ignoreSelf = true;
            };
            FakeNitro.enabled = true;
          };
        };
        useSystem = true;
      };
    };
  };

  xsession = {
    enable = true;
    windowManager.command = "exec dwm";
    initExtra = ''
      xset s 0 0
      xset s off
      xset dpms 0 0 0

      xss-lock -- sh -c 'xkb-switch -s us & i3lock -kc 000000' &

      status-bar > ~/.statusbar-start.log 2>&1 &
      screen-init > ~/.initialize-screen.log 2>&1 &
      $idle > ~/.idle.log 2>&1 &

      feh --no-fehbg --bg-fill ${../src/wallpaper.jpg} > .feh.log 2>&1 &
    '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "Adwaita-dark";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

}
