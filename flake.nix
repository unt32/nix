{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, ... }:
    let
      system = "x86_64-linux";
      username = "unt32";
      hostname = "nixos";
    in 
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
       
        username = "${username}";
        hostname = "${hostname}";

        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        
        inherit inputs system;
      };
      modules = [
        ./nixos/configuration.nix

        lanzaboote.nixosModules.lanzaboote
       ({ pkgs, lib, ... }: {
 
           environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot.
              pkgs.sbctl
            ];

            # Lanzaboote currently replaces the systemd-boot module.
            # This setting is usually set to true in configuration.nix
            # generated at installation time. So we force it to false
            # for now.
         boot.loader.systemd-boot.enable = lib.mkForce false;
 
           boot.lanzaboote = {
             enable = true;
             pkiBundle = "/etc/secureboot";
           };
       })
      ];
    };
    
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
     # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

      extraSpecialArgs = {
        inherit inputs;
        inherit system;
        unstable-pkgs = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        username = "${username}";
      };

      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
