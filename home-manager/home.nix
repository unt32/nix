{ homeStateVersion, user, pkgs, unstable, ... }: {
  imports = [
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [

        #dwm
        (dwm.overrideAttrs (oldAttrs: rec {
          src = ../src/dwm;
        }))

        #st
        (st.overrideAttrs (oldAttrs: rec {
          src = ../src/st;
        }))
/*
        #slstatus
        (slstatus.overrideAttrs (oldAttrs: rec {
          src = ../src/slstatus;
        }))
*/

        dmenu
        xautolock
        xss-lock
        xkb-switch
        pamixer
	alsa-utils
#	upower
	brightnessctl
#	acpilight
	
	
	rtorrent

	unstable.sbctl

        pavucontrol
	#firefox
	microsoft-edge
	lutris
	unstable.airshipper
	discord        

        powertop
        htop
        mc
        wget

	dconf
    ];
    
    sessionVariables = {
    	GDK_SCALE = "2.5";
	GDK_DPI_SCALE = "0.5";
    };
  };
  

  programs = {
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
      xss-lock slock &
      xautolock -time 5 -locker "slock" -killtime 15 -killer "systemctl suspend" -detectsleep &
      xrandr --output eDP-1 --primary --mode 3840x2400 --rate 60
    '';
  };

  services.dwm-status = {
    enable = true;
    order = [ "audio" "battery" "network" "time"];
    extraConfig = {
	  separator = " / ";

	  battery = {
	    notifier_levels = [ 2 5 10 15 20 ];
	  };

	  time = {
	    format = "%H:%M ";
	  };
	
	  audio = {
		template = " vol {VOL}%";
	  };
   };
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
