{
  description = "My custom shell scripts";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  };
  outputs = { self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      screen-init = pkgs.writeShellScriptBin "screen-init" (builtins.readFile ./initialize-screen.sh);
      status-bar = pkgs.writeShellScriptBin "status-bar" (builtins.readFile ./dwm-status-restart.sh);
      battery = pkgs.writeShellScriptBin "battery" (builtins.readFile ./battery.sh);
      plugged = pkgs.writeShellScriptBin "plugged" (builtins.readFile ./plugged.sh);
      powermenu = pkgs.writeShellScriptBin "powermenu" (builtins.readFile ./powermenu.sh);
    in
    {
      packages.x86_64-linux = {
        screen-init = screen-init;
        status-bar = status-bar;
        battery = battery;
        plugged = plugged;
        powermenu = powermenu;
      };
    };
  
}
