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
        { hostname = "P16G2"; stateVersion = "24.11"; fontSize = 26; pixelSize = 34; vdev = "eDP-1"; resolution = "3840x2400"; hz = "60"; idle = "battery"; }
        { hostname = "myPC"; stateVersion = "24.11"; fontSize = 14; pixelSize = 16; vdev = "DP-0"; resolution = "1920x1080"; hz = "165"; idle = "plugged";}
        { hostname = "vbox"; stateVersion = "24.11"; fontSize = 10; pixelSize = 16;}
    ];
    makeSystem = { hostname, stateVersion, fontSize, pixelSize, vdev, resolution, hz, idle }: nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs user stateVersion hostname lanzaboote unstable fontSize pixelSize vdev resolution hz idle;
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
          inherit (host) hostname stateVersion fontSize pixelSize vdev resolution hz idle;
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
