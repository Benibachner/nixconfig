{ self, inputs, ... }:
{
  flake.homeModules.blizzardModule =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.git
        self.homeModules.fish
        self.homeModules.alacritty
        self.homeModules.starship

        inputs.nix-index-database.homeModules.nix-index
      ];

      programs.neovim.enable = true;

      home.stateVersion = "25.05";

      nixpkgs.config.allowUnfreePredicate = _: true;
      home.packages = with pkgs; [
        fastfetch
        btop
        fzf
      ];

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      programs.home-manager.enable = true;

      programs.nix-index.enable = true;
    };
}
