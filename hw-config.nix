{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ata_piix" "ahci" "pata_jmicron" "firewire_ohci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/63fd75ba-7f3a-4c41-b679-fc464a305340";
      fsType = "ext4";
    };
    "/home/server/disk" = {
      device = "/dev/disk/by-uuid/8ce52a46-9d15-49e9-a1f5-adfb6f4cd1f3";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  };

  swapDevices = [ 
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
