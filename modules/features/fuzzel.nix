{ ... }:
{
  flake.homeModules.fuzzel =
    { pkgs, lib, ... }:
    {
      programs.fuzzel.enable = true;
    };
}
