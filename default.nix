{ config, pkgs, lib, ... }: {
  imports = [
      ./hw-config.nix

      ./system/fail2ban.nix
      ./system/docker.nix
      ./system/firewall.nix
      ./system/rules.nix

      ./services/nginx/default.nix
      ./services/nextcloud.nix
      ./services/syncthing.nix
      ./services/tailscale.nix
      ./services/pihole.nix
      ./services/grafana.nix
      ./services/jellyfin.nix
      ./services/samba.nix
      ./services/zapret.nix
    ]
    ++ lib.optional (builtins.pathExists ./services/stories_site/reverse-proxy.nix) ./services/stories_site/reverse-proxy.nix;

  boot = {
    kernelParams = [ "nomodeset" ]; 
    loader = {
      grub = {
        enable = true;
        efiSupport = false;
        device = "/dev/sda";
      };
    };
  };

  networking = {
    hostName = "p5kserv";
    domain = "homeserver.local";
    nameservers = [ "127.0.0.1" ];
    networkmanager.enable = true;
    
    defaultGateway = "192.168.0.1";
    interfaces.enp2s0 = {
      ipv4.addresses = [ 
        {
          address = "192.168.0.102";
	        prefixLength = 24;
        } 
      ];
    };
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Yekaterinburg";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.server = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
    openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1pkloDfjGIUmr+1iv81Sb9bSUJ67OZ3iIVc3uL77ho sophrosha@DESKTOP-N4TID67"
    ];
    home = "/home/server";
    homeMode = "0750";
   };

  environment.systemPackages = with pkgs; [
    neovim
    fastfetch
    wget
    git
    nh
    arion
    tree
    htop
    torrserver
    pciutils
  ];

  services.openssh = {
    enable = true;
    ports = [ 55 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
      AllowUsers = [ "server" ];
    };
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/server/.config/sops/age/keys.txt";
    };
  };

  system.stateVersion = "26.05";
}

