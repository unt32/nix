{ homeStateVersion, user, pkgs, unstable, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [


        pavucontrol
	dconf # for GTK
	firefox

        feh

        powertop
        htop
	rtorrent
        mc
        curl
        less
        tree
        blobdrop

        fpc
        binutils
        nasm
        gdb

	lutris
	wineWowPackages.full

        #unstable.airshipper
	
        prismlauncher
        jdk21
    ];
    
    sessionVariables = {
    };
  };
  

  programs = {
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

      feh --no-fehbg --bg-scale ${../src/wallpaper.jpg} > .feh.log 2>&1 &
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
