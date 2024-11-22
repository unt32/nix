{ pkgs, unstable-pkgs, ... }: {
    home.packages = with pkgs; [

        wineWowPackages.waylandFull 

        unstable-pkgs.airshipper

        # https://wiki.nixos.org/wiki/Minecraft
        atlauncher
        jre8
        
        lutris
        gamescope

        webcord

        unstable-pkgs.gimp
    ];

    imports = [
        ./foot.nix
        ./firefox.nix
        ./htop.nix
        ./git.nix
        ./vscode.nix
        ./rtorrent.nix
        ./mangohud.nix
        ./mpv.nix
        ./imv.nix
    ];
}