{ ... }:
{
  flake.homeModules.starship =
    { pkgs, lib, ... }:
    {
      programs.starship = {
        enable = true;
        settings = {
          add_newline = false;
          character = {
            success_symbol = "[](bold white) [➜](bold blue)";
            error_symbol = "[](bold white) [➜](bold red)";
          };
        };
      };
    };
}
