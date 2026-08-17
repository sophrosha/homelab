{ config, ... }: {
  services.nextcloud = {
    enable = true;
    hostName = "cloud.sophron.ru";
    #extraAppsEnable = true;
    #extraApps = {
    #  inherit (config.services.nextcloud.package.packages.apps) deck mail forms calendar music maps news cospend notes;
    #};
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
