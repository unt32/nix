{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, unstable-nixpkgs, home-manager, lanzaboote, ... }@inputs: let
    
    pkgs = import nixpkgs {
	inherit system;
	config.allowUnfree = true;
	};

    system = "x86_64-linux";
    homeStateVersion = "24.11";
    user = "unt32";
    hosts = [
        { hostname = "P16G2"; stateVersion = "24.11";}
        { hostname = "vbox"; stateVersion = "24.11";}
    ];
    unstable = import unstable-nixpkgs { inherit system; config.AllowUnFree = true; };
    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs stateVersion hostname;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        ({ config, pkgs, ... }: {
          users.users.${user} = {
            isNormalUser = true;
            home = "/home/${user}";
            extraGroups = [ "audio" "wheel" "networkmanager" ];
            shell = pkgs.bash;
          };
        })
	
	
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
              pkiBundle = "/var/lib/sbctl";
            };
          })
       
      ];
    };
  
  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
      configs // {
        "${host.hostname}" = makeSystem {
          inherit (host) hostname stateVersion;
        };
      }) {} hosts;

    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs;
      extraSpecialArgs = {
        inherit inputs homeStateVersion user unstable;
      };

      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
