{ pkgs, unstable-pkgs, ... }: {
    home.packages = with pkgs; [
        wineWowPackages.waylandFull

        unstable-pkgs.airshipper

        onlyoffice-bin

        atlauncher
        jre8

        webcord
        viber
    ];

    imports = [
        ./foot.nix
        ./firefox.nix
        ./htop.nix
        ./git.nix
        ./vscode.nix
    ];
}