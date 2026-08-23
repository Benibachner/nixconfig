{ self, inputs, ... }:
{
  flake.nixosModules.blizzardConfiguration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.nix-index-database.nixosModules.nix-index
        inputs.home-manager.nixosModules.default

        self.nixosModules.blizzardDisko
        self.nixosModules.blizzardHardware
        # ./hardware-configuration.nix
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };

      home-manager.users.benedikt = self.homeModules.blizzardModule;

      users.users.root.openssh.authorizedKeys.keys = [
        # change this to your ssh key
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvNc7Y9BZhPt/bc/bjwN0K6a6wXEsAQ5XYCbizcuX6z benedikt@snowflake"
      ];

      # Bootloader.
      boot.loader.grub = {
        enable = true;
        efiSupport = true;
        # Bei UEFI-Systemen wird kein direktes Device ("nodev") eingetragen,
        # da GRUB in die EFI-Partition schreibt
        devices = [ "nodev" ];
      };
      boot.loader.efi.canTouchEfiVariables = true;

      # boot.extraModulePackages = with config.boot.kernelPackages; [ yt6801 ];
      boot.kernelParams = [ ];
      # boot.kernelPackages = pkgs.linuxPackages_latest;

      boot = {
        loader.systemd-boot = {
          enable = lib.mkForce false;
          configurationLimit = 10;
        };
        initrd.systemd.enable = true;
      };

      networking.hostName = "blizzard";

      time.timeZone = "Europe/Vienna";

      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_AT.UTF-8";
        LC_IDENTIFICATION = "de_AT.UTF-8";
        LC_MEASUREMENT = "de_AT.UTF-8";
        LC_MONETARY = "de_AT.UTF-8";
        LC_NAME = "de_AT.UTF-8";
        LC_NUMERIC = "de_AT.UTF-8";
        LC_PAPER = "de_AT.UTF-8";
        LC_TELEPHONE = "de_AT.UTF-8";
        LC_TIME = "de_AT.UTF-8";
      };

      # Enable sound with pipewire.
      services.pulseaudio.enable = false;

      services.blueman.enable = true;

      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
      };

      services.tailscale.enable = false;

      services.openssh.enable = true;

      users.users.benedikt = {
        isNormalUser = true;
        description = "Benedikt";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 1w --keep 3";
        flake = "/home/benedikt/nixconfig/";
      };

      programs.neovim.enable = true;
      programs.neovim.defaultEditor = true;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
        home-manager
        comma

        git
        just
        ripgrep
        podman-compose
      ];

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?

      programs.nix-ld.enable = true;

      programs.bash = {
        interactiveShellInit = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };

      virtualisation = {
        libvirtd = {
          enable = false;
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
          };
        };

        podman = {
          enable = true;

          # Create a `docker` alias for podman, to use it as a drop-in replacement
          dockerCompat = true;

          # Required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      services = {
        spice-vdagentd.enable = true;
        spice-webdavd.enable = true;
      };

      programs.virt-manager.enable = false;

    };
}
