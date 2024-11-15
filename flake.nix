{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "baran";
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
