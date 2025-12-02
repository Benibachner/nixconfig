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

    opacity.terminal = 0.4;

    firefox.profileNames = ["default"];

    fonts = {
      sizes = {
	terminal = 14;
      };
      monospace = {
	name = "JetBrains Mono Nerd Font";
	package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
  };
}
