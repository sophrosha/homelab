{ lib, ... }: {
  imports = [ ./domain.nix ];
  services.nginx = {
    enable = true;
    virtualHosts."sophron.ru" = {
      enableACME = true;
      forceSSL = true;
      default = true;
      root = if builtins.pathExists ./bio then "${./bio}" else "/var/empty";
    };
  };
}
