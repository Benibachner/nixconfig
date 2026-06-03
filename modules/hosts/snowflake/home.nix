{ self, inputs, ... }:
{
  flake.homeModules.benediktModule =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.git
        self.homeModules.fish
        self.homeModules.hyprland
        self.homeModules.waybar
        self.homeModules.firefox
        self.homeModules.alacritty
        self.homeModules.stylix
        self.homeModules.starship
        self.homeModules.fuzzel

        inputs.nix-index-database.homeModules.nix-index
      ];

      # programs.neovim.enable = true;

      home.stateVersion = "25.05";

      nixpkgs.config.allowUnfreePredicate = _: true;
      home.packages = with pkgs; [
        nil
        nerd-fonts.jetbrains-mono
        fastfetch
        bibata-cursors
        wl-clipboard
        brightnessctl
        hyprshot
        gcr
        pwvucontrol
        typst
        terraform
        rustfmt
        codex
        nmap
        btop
        opencode
        fzf

        chromium
        prismlauncher
        obsidian
        libreoffice
        networkmanagerapplet
        kdePackages.kdenlive
      ];

      services.polkit-gnome.enable = true;
      # services.gnome-keyring.enable = true;

      home.pointerCursor = {
        gtk.enable = true;
        # x11.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };

      home.sessionVariables = {
        EDITOR = "nvim";
      };

      programs.home-manager.enable = true;

      programs.nix-index.enable = true;
    };
}
