{ inputs, ... }:
{
  flake.modules.nixos.base = { system, ... }: {
    nixpkgs.overlays = [
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit system;
          config.allowUnfree = prev.config.allowUnfree or false;
        };
      })
    ];
  };
}
