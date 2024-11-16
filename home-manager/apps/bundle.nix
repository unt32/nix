{ pkgs, unstable-pkgs, ... }: {
    home.packages = with pkgs; [

        wineWowPackages.waylandFull 

        unstable-pkgs.airshipper

        # https://wiki.nixos.org/wiki/Minecraft
        atlauncher
        jre8
        
        webcord
    ];

    imports = [
        ./foot.nix
        ./firefox.nix
        ./htop.nix
        ./git.nix
        ./vscode.nix
    ];
}