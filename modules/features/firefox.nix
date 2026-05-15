{ ... }:
{
  flake.homeModules.firefox =
    { pkgs, lib, ... }:
    {
      programs.firefox = {
        enable = true;
        profiles = {
          default = { };
        };
      };
    };
}
