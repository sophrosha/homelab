{ config, ... }: {
  services.nextcloud = {
    enable = true;
    hostName = "cloud.sophron.ru";
    maxUploadSize = "100000M";
    https = true;
    config = {
      dbtype = "sqlite";
      adminpassFile = "/etc/nextcloudpass";
    };
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}" = {
    forceSSL = true;
    useACMEHost = "sophron.ru";
  };
}
