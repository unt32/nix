{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  #  ags.url = "github:Aylur/ags";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "unt32";
      hostname = "nixos";
    in 
  {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs = {
       # pkgs = import nixpkgs {
       #   inherit system;
       #   config.allowUnfree = true;
       # };

        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        
        inherit inputs system;
      };
      modules = [
        ./nixos/configuration.nix
      ];
    };
    
    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
     # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

      extraSpecialArgs = {
        inherit inputs;
        pkgs-unstable = import nixpkgs-unstable {
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