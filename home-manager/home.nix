{ homeStateVersion, user, pkgs, unstable, ... }: {

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

        dmenu
        xautolock
        xss-lock
        xkb-switch
	alsa-utils
	brightnessctl

	xclip
	scrot

	feh	

        pavucontrol
	firefox
	lutris
	unstable.airshipper
	
	prismlauncher
	jdk21

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
/*	QT_SCALE_FACTOR = "2.5";
    	GDK_SCALE = "2.5";
	GDK_DPI_SCALE = "0.5";
	MOZ_USE_XINPUT2 = "1";	 
   	_JAVA_AWT_WM_NONREPARENTING = "1";
*/
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
      xss-lock -- sh -c 'xkb-switch -s us & slock' &
      xautolock -time 5 -locker 'xkb-switch -s us & slock' -killtime 15 -killer 'systemctl suspend' -detectsleep &

      xrandr --output eDP-1 --mode 3840x2400 --primary --rate 60 &
      ${builtins.toString ../src/dwm-status-restart.sh} &
    '';
  };

  services.dwm-status = {
    enable = true;
    order = [ "audio" "backlight" "battery" "network" "time"];
    extraConfig = {
	  separator = " / ";

          backlight = {
            device = "amdgpu_bl1";
            template = "bl {BL}%";
          };

	  battery = {
	    notifier_levels = [ 2 5 10 15 20 ];
	  };

	  time = {
	    format = "%H:%M ";
	  };
	
	  audio = {
 		mute = " mute";
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
