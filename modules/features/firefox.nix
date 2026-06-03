{ ... }:
{
  flake.homeModules.firefox =
    { pkgs, lib, config, ... }:
    {
      programs.firefox = {
        enable = true;
	configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles = {
          default = { };
        };
      };
    };

}
