{ homeStateVersion, user, pkgs, unstable, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [


        pavucontrol
	firefox
	lutris
        #unstable.airshipper
	
        #prismlauncher
        #jdk21

        powertop
        htop
	rtorrent
        mc
        curl
        less
        tree

        fpc
        binutils


	dconf

	wineWowPackages.full
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
    };
  };
  
  xsession = {
    enable = true;
    windowManager.command = "exec dwm";
    initExtra = ''
      xset s 0 0
      xset s off
      xset dpms 0 0 0
      xset -dpms

      xss-lock -- sh -c 'xkb-switch -s us & slock' &

      ${builtins.toString ../src/dwm-status-restart.sh} > ~/.dwm-status-restart.log 2>&1 &
      ${builtins.toString ../src}/"$idle".sh > ~/.xidlehook.log 2>&1 &

      echo "Hello |$vdev| on |$resolution| |$hz| |$idle|" > ~/test
      xrandr --output "$vdev" --mode "$resolution" --refresh "$hz" --primary
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
