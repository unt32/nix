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

      ${builtins.toString ../src/scripts}/dwm-status-restart.sh > ~/.dwm-status-restart.log 2>&1 &
      ${builtins.toString ../src/scripts}/initialize-screen.sh > ~/.initialize-screen.log 2>&1 &
      ${builtins.toString ../src/scripts}/"$idle".sh > ~/.xidlehook.log 2>&1 &
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
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-theme-name = "Adwaita-dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-cursor-theme-name = "Bibata-Modern-Classic";
      gtk-font-name = "JetBrains Mono 11";
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

}
