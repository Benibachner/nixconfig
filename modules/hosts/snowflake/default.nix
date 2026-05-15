{ self, inputs, ... }:
{
  flake.nixosConfigurations.snowflake = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.snowflakeConfiguration
    ];
  };

  flake.homeConfigurations.benedikt = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.benediktModule
      {
        home.username = "benedikt";
        home.homeDirectory = "/home/benedikt";
      }
    ];
  };
}
