{
  description = "Benibachner's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  }: {
    nixosConfigurations.snowflake = nixpkgs.lib.nixosSystem {
      #specialArgs = {inherit inputs system;};
      system = "x86_64-linux";

      modules = [
        nvf.nixosModules.default
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.benedikt = import ./home.nix;
        }
      ];
    };
  };
}
