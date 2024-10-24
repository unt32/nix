{ pkgs, pkgs-unstable, config,  ... }: {

    nixpkgs.config.allowUnfree = true;
 #   nixpkgs-unstable.config.allowUnfree = true;

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
