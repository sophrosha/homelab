{ lib, ... }: {
  imports = [ ./domain.nix ];
  services.nginx = {
    enable = true;
    virtualHosts."sophron.ru" = {
      enableACME = true;
      forceSSL = true;
      default = true;
      root = lib.optional (builtins.pathExists ./bio) ./bio;
    };
  };
}
