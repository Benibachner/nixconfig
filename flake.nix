{
  description = "Benibachner's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nixvim, disko, stylix, nixpkgs-unstable, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      pkgs-unstable = import nixpkgs-unstable {
	inherit system;
      };

      specialArgs = {
      inherit inputs pkgs-unstable;
      };
    in {
      nixosConfigurations.snowflake = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	inherit specialArgs;

        modules = [ 
          ./system/configuration.nix

          disko.nixosModules.disko
          ./system/disko.nix
        ];
      };

      homeConfigurations."benedikt" =
        home-manager.lib.homeManagerConfiguration {
	  extraSpecialArgs = specialArgs;
          inherit pkgs;

          modules = [ ./home.nix ./desktop ./terminal nixvim.homeModules.nixvim ];
        };
    };
}
