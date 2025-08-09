{
  description = "My system configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unstable-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myscripts-repo = {
      url = "./src/scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      unstable-nixpkgs,
      home-manager,
      lanzaboote,
      myscripts-repo,
      ...
    }@inputs:
    let

      system = "x86_64-linux";
      homeStateVersion = "25.05";
      user = "unt32";
      hosts = [
        {
          hostname = "P16G2";
          stateVersion = "25.05";
        }
        {
          hostname = "myPC";
          stateVersion = "25.05";
        }
      ];

      scripts = myscripts-repo.packages.${system};

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import unstable-nixpkgs {
        inherit system;
        config.AllowUnFree = true;
      };

      makeSystem =
        { hostname, stateVersion }:
        nixpkgs.lib.nixosSystem {
          system = system;
          specialArgs = {
            inherit
              inputs
              user
              stateVersion
              hostname
              lanzaboote
              unstable
              scripts
              ;
          };

          modules = [
            ./hosts/${hostname}/configuration.nix
            ./hosts/common.nix
          ];
        };

    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${host.hostname}" = makeSystem {
            inherit (host) hostname stateVersion;
          };
        }
      ) { } hosts;

      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {
          inherit
            inputs
            homeStateVersion
            user
            unstable
            ;
        };

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
