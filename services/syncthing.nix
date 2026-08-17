{ ... }: {
  services = {
    syncthing = {
      enable = true;
      user = "server";
      group = "users";
      dataDir = "/home/server";
      openDefaultPorts = true;
      guiAddress = "127.0.0.1:8384";
      overrideDevices = false;
      overrideFolders = false;
    };
    nginx.virtualHosts."syncthing.server.local" = {
      forceSSL = false;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8384";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    }
  };
}
