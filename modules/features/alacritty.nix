{ ... }:
{
  flake.homeModules.alacritty =
    { pkgs, lib, ... }:
    {
      programs.alacritty = {
        enable = true;
        settings = {
          window.padding = {
            x = 10;
            y = 10;
          };
          keyboard.bindings = [
            {
              key = "Return";
              mods = "Control|Shift";
              action = "SpawnNewInstance";
            }
          ];
        };
      };
    };
}
