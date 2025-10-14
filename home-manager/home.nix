{
  homeStateVersion,
  user,
  pkgs,
  unstable,
  ...
}:
let
  homeDir = "/home/${user}";
in
{

  home = {
    username = user;
    homeDirectory = homeDir;
    stateVersion = homeStateVersion;

    packages = with pkgs; [

      pavucontrol
      dconf # for GTK
      firefox
      mpv
      feh

      lutris
      wineWowPackages.full

      #prismlauncher
      #jdk21

      arandr

      powertop
      htop

      # LF
      highlight
      poppler-utils
      bat
      timg

      rtorrent
      curl

      systemctl-tui

      pv
      less
      tree
      file
      blobdrop
      p7zip
      ntfs3g
      simple-mtpfs
    ];

    sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      OPENER = "openit";
    };
  };

  programs = {
    bash = {
      enable = true;
      bashrcExtra = ''
        alias rs='echo -e "\nrebuild switch\n"; sudo nixos-rebuild switch --flake ~/nix'
        alias rb='echo -e "\nrebuild boot\n"; sudo nixos-rebuild boot --flake ~/nix'
        alias rt='echo -e "\nrebuild test\n"; sudo nixos-rebuild test --flake ~/nix'

        alias hs='echo -e "\nhome-manager switch\n"; home-manager switch --flake ~/nix/'

        alias fwopen='sudo nft add rule inet nixos-fw input tcp dport 1414 accept'
        alias fwlist='sudo nft list ruleset'
        alias fwclose='sudo systemctl restart nftables.service'

        alias sctl=systemctl-tui
      '';
    };

    lf = {
      enable = true;
      previewer = {
        source = pkgs.writeShellScript "preview.sh" ''
          #!/bin/sh

          file "$1"
          case "$1" in
              *.tar*) tar tf "$1";;
              *.7z|*.rar|*.zip) 7z l "$1";;
              *.pdf) pdftotext "$1" -;;
              *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.webp|*.tiff|*.mp4|*.mov|*.avi) timg -g 80x40 --frames 1 "$1";;
              *) highlight -O xterm256 "$1" || cat "$1";;
          esac
        '';
      };
      keybindings = {
        D = "trash";
        W = "setbg";
        f = "filetype";
        b = "filedrop";
      };
      commands = {
        trash = "%[ -n \"$fs\" ] && mv $fs ~/trash/ || mv $f ~/trash/";
        setbg = "%feh --bg-fill $f";
        filedrop = "%[ -n \"$fs\" ] && blobdrop $fs || blobdrop $f";
        filetype = "%file $f";
      };
      extraConfig = ''
        $mkdir -p ~/trash
      '';
    };

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

    ssh = {
      enable = true;
      compression = true;
      extraConfig = "
        Host github.com
                IdentityFile ~/.ssh/git
        Host myPC
                IdentityFile ~/.ssh/myPC
                Port 39651
                User unt32
                HostName 10.147.17.0
        Host P16G2
                IdentityFile ~/.ssh/P16G2
                Port 39651
                User unt32
                HostName 10.147.17.1
      ";
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

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  xdg = {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${homeDir}/downloads";
      desktop = "${homeDir}/.xdg-shit/desktop";
      documents = "${homeDir}/.xdg-shit/documents";
      music = "${homeDir}/.xdg-shit/music";
      pictures = "${homeDir}/.xdg-shit/pictures";
      publicShare = "${homeDir}/.xdg-shit/publicShare";
      templates = "${homeDir}/.xdg-shit/templates";
      videos = "${homeDir}/.xdg-shit/videos";
    };
  };

}
