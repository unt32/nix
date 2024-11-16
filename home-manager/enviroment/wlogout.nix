{ pkgs, ... }: {
  programs.wlogout = {
    enable = true;

    layout = [
      {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "q";
      }
      {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
          keybind = "w";
      }
      {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "e";
      }
    ];

    style = ''
                * {
              background-image: none;
              box-shadow: none;
            }

            window {
              background-color: rgba(0, 0, 0, 0.6);
              border-radius: 0;
            }

            button {
              border-radius: 50px;
              border-color: transparent;
              margin: 5.0em 1.0em;
              padding: 1.0em;
              text-decoration-color: #2b2e37;
              color: #2b2e37;
              background-color: #2b2e37;
              border-style: solid;
              border-width: 1px;
              background-repeat: no-repeat;
              background-position: center;
              background-size: 25%;
              outline-style: none;
            }

            button:focus, button:active {
              text-decoration-color: #B8B8B8;
              color: #B8B8B8;
              outline-style: none;
            }
            button:hover {
              background-color: #151515;
              text-decoration-color: #151515;
              color: #151515;
              outline-style: none;
            }

            #lock {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"), url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
            }

            #logout {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"), url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
            }

            #suspend {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"), url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
            }

            #hibernate {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"), url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
            }

            #shutdown {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"), url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
            }

            #reboot {
                background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"), url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
            }
    '';
  };
}