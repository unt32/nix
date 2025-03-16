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

    unstable = import unstable-nixpkgs {
      inherit system;
      config.AllowUnFree = true;
    };

    system = "x86_64-linux";
    homeStateVersion = "24.11";
    user = "unt32";
    hosts = [
        { hostname = "P16G2"; stateVersion = "24.11";}
        { hostname = "vbox"; stateVersion = "24.11";}
    ];
    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs user stateVersion hostname lanzaboote unstable;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        ./hosts/common.nix
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
