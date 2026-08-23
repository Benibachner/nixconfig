{ inputs, ... }:
{
  flake.homeModules.stylix =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        inputs.stylix.homeModules.stylix
      ];

      stylix = {
        enable = true;

        polarity = "dark";

        base16Scheme = "${pkgs.base16-schemes}/share/themes/solarized-dark.yaml";

        # override = {
        #   base08 = "d17b2e";
        #   base0B = "8C9288";
        # };

        # opacity.terminal = 0.7;

        # targets.firefox.profileNames = [ "default" ];

        image = ./wallpapers/winter-hut.jpg;

        targets = {
          # neovim.enable = false;
          firefox.enable = false;
        };

        fonts = {
          sizes = {
            terminal = 13;
            popups = 14;
          };
          monospace = {
            name = "JetBrains Mono Nerd Font";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };
        };
      };
    };
}
