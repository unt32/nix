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

        dmenu
        #slstatus
        xautolock
        xss-lock
        xkb-switch
        pamixer

        pavucontrol
        firefox
        

        powertop
        htop
        mc
        wget
    ];
  };
  

  programs = {
    git = {
        enable = true;
    };
  };

  
  xsession = {
    enable = true;
    windowManager.command = "exec dwm";
    initExtra = ''
      xss-lock -- slock &
      xautolock -time 5 -locker "systemctl suspend" &
      xrandr --output Virtual-1 --primary --mode 2560x1600 --rate 60
    '';

  };

  services.dwm-status = {
    enable = true;
    order = ["battery" "network" "time"];
  };

 /* gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";  # Или другая тема, например "Arc-Dark"
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";  # Или другая тёмная тема
      package = pkgs.papirus-icon-theme;
    };
  };*/
}