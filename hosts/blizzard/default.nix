{ self, inputs, ... }:
{
  flake.nixosConfigurations.blizzard = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.blizzardConfiguration
    ];
  };
}
