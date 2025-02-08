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
	
	#slstatus
	(slstatus.overrideAttrs (oldAttrs: rec {
          src = ../src/slstatus;
        }))


        dmenu
        xautolock
        xss-lock
        xkb-switch
        pamixer
	alsa-utils
	brightnessctl
	

	unstable.sbctl

        pavucontrol
	firefox
	lutris
	unstable.airshipper        

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
    };
  };
  
  programs.mangohud = {
	enable = true;
  };
  
  xsession = {
    enable = true;
    windowManager.command = "exec dwm";
    initExtra = ''
      xss-lock slock &
      xautolock -time 5 -locker "slock" -killtime 15 -killer "systemctl suspend" -detectsleep &
      xrandr --output eDP-1 --primary --mode 3840x2400 --rate 60
    '';
 
#  initExtra = "st & ";
  };

  services.dwm-status = {
    enable = true;
    order = [ "battery" "network" "time"];
   /* extraConfig = {
	  separator = "#";

	  battery = {
	    notifier_levels = [ 2 5 10 15 20 ];
	  };

	  time = {
	    format = "%H:%M";
	  };
	};*/
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark"; 
    };
  };

}
