{ ... }: {
  imports = [ ./domain.nix ];
  services.nginx = {
    enable = true;
    virtualHosts."sophron.ru" = {
      enableACME = true;
      forceSSL = true;
      default = true;
      root = ./bio;
    };
  };
}
