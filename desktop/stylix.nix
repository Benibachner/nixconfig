{
  pkgs,
  inputs,
  ...
}: {
  imports = [
      inputs.stylix.homeModules.stylix
  ];
  
  stylix = {
    enable = true;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atlas.yaml";

    opacity.terminal = 0.7;

    targets.firefox.profileNames = ["default"];

    image = ./wallpapers/marveling.jpg;

    fonts = {
      sizes = {
	terminal = 13;
	popups = 14;
	applications = 14;
	desktop = 14;
      };
      monospace = {
	name = "JetBrains Mono Nerd Font";
	package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
  };
}
