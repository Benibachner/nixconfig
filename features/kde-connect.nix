{ ... }:
{
  flake.nixosModules.kde-connect =
    { pkgs, lib, ... }:
    {
      programs.kdeconnect.enable = true;
    };
}
