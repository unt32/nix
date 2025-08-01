{ homeStateVersion, user, pkgs, unstable, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [


        pavucontrol
	dconf # for GTK
	firefox
        discord

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
