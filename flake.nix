{
  description = "Benibachner's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    nvf,
    ...
  }: {
    nixosConfigurations.snowflake = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nvf.nixosModules.default
        ./system/configuration.nix
      ];
    };
  };
}
