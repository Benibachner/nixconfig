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
      ];

      programs.neovim.enable = true;

      home.stateVersion = "25.05";

      nixpkgs.config.allowUnfreePredicate = _: true;
      home.packages = with pkgs; [
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

        chromium
        prismlauncher
        obsidian
        libreoffice
        networkmanagerapplet
        jetbrains.idea
        jetbrains.pycharm
        blueman

        nil
      ];

      xdg.configFile."JetBrains/IntelliJIdea${pkgs.jetbrains.idea.version}/idea64.vmoptions".text =
        "-Dawt.toolkit.name=WLToolkit";

      services.polkit-gnome.enable = true;
      services.gnome-keyring.enable = true;

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
