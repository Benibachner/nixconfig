{ inputs, ... }:
{
  flake.nixosModules.unstable = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = prev.config.allowUnfree or false;
        };
      })
    ];
  };

  flake.homeModules.unstable = { pkgs, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = prev.stdenv.hostPlatform.system;
          config.allowUnfree = true;
        };
      })
    ];
  };
}
