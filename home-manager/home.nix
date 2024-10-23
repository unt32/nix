{ pkgs, pkgs-unstable, config,  ... }: {

    pkgs.config.allowUnfree = true;

    imports = [
        ./apps/bundle.nix
        ./enviroment/bundle.nix
    ];

    home = {
        username = "unt32";
        homeDirectory = "/home/unt32";
        stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
}