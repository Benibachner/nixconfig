{ self, inputs, ... }:
{
  flake.nixosModules.snowflakeHardware =
    {
      pkgs,
      lib,
      config,
      modulesPath,
      ...
    }:
    {

      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "sd_mod"
        "sdhci_pci"
      ];
      boot.initrd.kernelModules = [ "amdgpu" ];
      boot.kernelModules = [
        "kvm-amd"
        "snd_hda_intel"
        "tuxedo_io"
      ];
      boot.extraModprobeConfig = ''
        options iwlwifi disable_11ax=1
      '';
      # options snd_hda_intel power_save=0 power_save_controller=N

      boot.extraModulePackages = [ ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      hardware.enableAllFirmware = true;
    };
}
