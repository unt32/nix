{ homeStateVersion, user, pkgs, unstable, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [

        #GNOME 
        gnomeExtensions.just-perfection
        gnome-tweaks
        bibata-cursors

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
