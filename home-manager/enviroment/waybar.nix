{
  programs.waybar = {
    enable = true;
    settings = {
        mainBar = {
            layer = "top";
            position = "top";
            height = 34;
            spacing = 4;

            modules-left = ["hyprland/workspaces" "pulseaudio" "backlight" "hyprland/language"];
            modules-center = ["hyprland/window"];
            modules-right = ["hyprland/submap" "cpu" "memory" "temperature" "battery" "tray" "clock"];

            "hyprland/workspaces" = {
                disable-scroll = true;
                on-click = "activate";
                format = "{name}";
                on-scroll-up = "hyprctl dispatch workspace m-1 > /dev/null";
                on-scroll-down = "hyprctl dispatch workspace m+1 > /dev/null";
                format-icons = {
                    "1" = "";
                    "2" = "";
                    "3" = "";
                    "4" = "";
                    "5" = "";
                    "urgent" = "";
                    "focused" = "";
                    "default" = "";
                };
            };

            keyboard-state = {
                numlock = false;
                capslock = false;
                format = "{name} {icon}";
                format-icons = {
                    locked = "";
                    unlocked = "";
                };
            };
                    
            "hyprland/window" = {
                max-length = 50;
                separate-outputs = true;
            };

            "hyprland/language" = {
              format-en = "EN";
              format-ru = "RU";
              min-length = 1;
              tooltip = false;
            };

            idle_inhibitor = {
                format = "{icon}";
                format-icons = {
                    activated = "";
                    deactivated = "";
                };
            };

            tray = {
                icon-size = 24;
                spacing = 0;
            };

            clock = {
                # timezone = "America/New_York";
                tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                format-alt = "{:%d.%m.%Y}";
            };

            cpu = {
                interval = 1;
                format = "{usage}% ";
                tooltip = false;
                on-click = "foot htop";
            };

            memory = {
                interval = 1;
                format = "{}% ";
                on-click = "foot htop";
            };

            temperature = {
                interval = 1;
                # thermal-zone = 2;
                # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
                critical-threshold = 80;
                # format-critical = "{temperatureC}°C {icon}";
                format = "{temperatureC}°C {icon}";
                format-icons = ["" "" ""];
            };

            backlight = {
                # device = "acpi_video1";
                format = "{percent}% {icon}";
                format-icons = ["" "" "" "" "" "" "" "" ""];
            };

            battery = {
                states = {
                    # good = 95;
                    warning = 30;
                    critical = 15;
                };
                format = "{capacity}% {icon}";
                format-charging = "{capacity}% 🗲";
                format-plugged = "{capacity}% ";
                # format-alt = "{time} {icon}";
                # format-good = ""; # An empty format will hide the module
                # format-full = "";
                format-icons = ["" "" "" ""  ""];
            };

            network = {
            # "interface" = "wlan0"; # (Optional) To force the use of this interface
                format-wifi = "{essid} ";
                format-ethernet = "{ipaddr}/{cidr} ";
                tooltip-format = "{ifname} via {gwaddr} ";
                format-linked = "{ifname} (No IP) ";
                format-disconnected = "Disconnected ⚠";
                format-alt = "{ifname}: {ipaddr}/{cidr}";
            };

            pulseaudio = {
                # "scroll-step" = 10; # %; can be a float
                format = "{volume}% {icon}  {format_source}";
                format-bluetooth = "{volume}% {icon}  {format_source}";
                format-bluetooth-muted = "  {format_source}";
                format-muted = "  {format_source}";
                format-source = "{volume}% ";
                format-source-muted = "";
                format-icons = {
                    headphone = "";
                    hands-free = "";
                    headset = "";
                    phone = "";
                    portable = "";
                    car = "";
                    default = ["" "" ""];
                };
                on-click = "pgrep pavucontrol && hyprctl dispatch togglespecialworkspace || pavucontrol";
            };
        };
    };
  
    style = 
      ''
@define-color base00 #181818;
@define-color base01 #2b2e37;
@define-color base02 #3b3e47;
@define-color base03 #585858;
@define-color base04 #b8b8b8;
@define-color base05 #d8d8d8;
@define-color base06 #e8e8e8;
@define-color base07 #f8f8f8;
@define-color base08 #ab4642;
@define-color base09 #dc9656;
@define-color base0A #f7ca88;
@define-color base0B #a1b56c;
@define-color base0C #86c1b9;
@define-color base0D #7cafc2;
@define-color base0E #ba8baf;
@define-color base0F #a16946;

* {
  transition: none;
  box-shadow: none;
}

#waybar {
	font-family: 'Source Code Pro', sans-serif;
	font-size: 1.0em;
	font-weight: 400;
  color: @base04;
  background: @base01;
  border-radius: 0;
}

#workspaces {
  margin: 0 2px;
}

#workspaces button {
  margin: 4px 0;
  padding: 0 4px;
  color: @base05;
}

#workspaces button.visible {
}

#workspaces button.active {
  border-radius: 4px;
  background-color: @base02;
}

#workspaces button:hover {
  background: @base02;
  border: none;
}

#workspaces button.urgent {
  color: rgba(238, 46, 36, 1);
}

#tray {
  margin: 4px 4px 4px 4px;
  border-radius: 4px;
  background-color: @base02;
}

#tray * {
  padding: 0 1px 0 4px;
}

#tray *:first-child {
  margin: 0 2px 0 1px;
}

#mode, #battery, #cpu, #memory, #network, #pulseaudio, #idle_inhibitor, #backlight, #clock, #temperature, #language{
  margin: 4px 1px;
  padding: 0 6px;
  background-color: @base02;
  border-radius: 4px;
  min-width: 20px;
}

#battery, #network {
  padding-right: 5px;
}

#pulseaudio.muted {
  color: @base0F;
}

#pulseaudio.bluetooth {
  color: @base0C;
}

#clock {
  margin-left: 0px;
  margin-right: 4px;
  padding: 0px 6px;
  font-size: 1.2em;
  background-color: @base02;
}

#temperature.critical {
  color: @base0F;
}

#window {
  font-size: 0.9em;
	font-weight: 400;
	font-family: sans-serif;
}

#language {
	font-size: 0.9em;
	font-weight: 500;
	letter-spacing: -1px;
}

tooltip {
    border-radius: 4px;
    background-color: @base01;
    opacity: 0.9;
}
      '';
  };
}