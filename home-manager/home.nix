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
	extraConfig = "colorscheme torte"; 
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
   '';
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "Adwaita-dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-font-name = "JetBrains Mono 11";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

}
