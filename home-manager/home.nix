{ pkgs, config, username,  ... }: {

    nixpkgs.config.allowUnfree = true;

    imports = [
        ./apps/bundle.nix
        ./enviroment/bundle.nix
    ];

    home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "24.05";
    };

    programs.home-manager.enable = true;
}
