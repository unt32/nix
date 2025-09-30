{
  description = "My custom shell scripts";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  };
  outputs =
    { self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux = {
        battery = pkgs.writeShellScriptBin "battery" (builtins.readFile ./battery.sh);
        plugged = pkgs.writeShellScriptBin "plugged" (builtins.readFile ./plugged.sh);
        powermenu = pkgs.writeShellScriptBin "powermenu" (builtins.readFile ./powermenu.sh);
        openit = pkgs.writeShellScriptBin "openit" (builtins.readFile ./openit.sh);
      };
    };

}
