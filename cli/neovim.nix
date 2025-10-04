{
  inputs,
  pkgs,
  nixvim,
  ...
}: {
  programs.nixvim = {
    enable = true;

    nixpkgs.useGlobalPackages = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
	lightline.enable = true;
    };

    opts = {
	number = true;
	relativenumber = true;
	shiftwidth = 2;
    };
  };
}
