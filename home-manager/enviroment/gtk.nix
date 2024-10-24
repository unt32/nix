{pkgs, ...}: {
  gtk = {
    enable = true;
    
    theme = {
      name = "Pop-dark";
      package = pkgs.pop-gtk-theme;
    };

    iconTheme = {
      name = "Vimix-Doder";
      package = pkgs.vimix-icon-theme;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}