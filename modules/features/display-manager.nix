{ ... }:
{
  flake.nixosModules.display-manager =
    { pkgs, lib, ... }:
    {
      #services.greetd = {
      #  enable = true;
      #};
      #programs.regreet = {
      #  enable = true;

      #  theme.name = "Adwaita-dark";

      #  settings = {
      #    background = {
      #      path = "/home/benedikt/nixconfig/modules/features/stylix/wallpapers/switzerland-snowfall.jpg"; # Pfad zu deinem Wallpaper
      #      fit = "Cover"; # Optionen: "Contain", "Cover", "Fill", "ScaleDown"
      #    };
      #  };
      #};

      services.displayManager.gdm.enable = true;
      services.displayManager.defaultSession = "hyprland";
      #
      #services.greetd = {
      #  enable = true;
      #};
      #programs.regreet.enable = true;

      services.desktopManager.gnome.enable = true;
    };
}
