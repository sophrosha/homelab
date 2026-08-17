{ lib, ... }: {
  services = { 
    jellyfin = {
      enable = true;
      openFirewall = true;
      hardwareAcceleration.enable = false;
    };
    qbittorrent = {
      enable = true;
      user = "qbtr";
      group = "qbtr";
      webuiPort = 8791;
    };
    nginx.virtualHosts = {
      "kino.server.local" = {
        forceSSL = false;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8096";
	        proxyWebsockets = true;
	        extraConfig = ''
            proxy_pass_header Authorization;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
	        '';
	      };
      };
      "torr.server.local" = {
          forceSSL = false;
	        locations."/" = {
            proxyPass = "http://127.0.0.1:9117";
	          proxyWebsockets = true;
	        };
      };
      "qtorr.server.local" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:8791";
	        proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host $host;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
    };
    jackett.enable = true;
    flaresolverr.enable = true;
  };
  systemd.services = {
    jellyfin.serviceConfig = { 
      ProtectHome = lib.mkForce false;
      ReadOnlyPaths = [ "/home/server/disk/public/Киношки" ];
    };
    qbittorrent.serviceConfig = {
      ProtectHome = lib.mkForce false;
      ReadWritePaths = [ "/home/server/disk/public/Киношки" ];
    };
  };
  users = {
    groups.qbtr = {};
    users = {
      "jellyfin".extraGroups = [ "users" ];
      "qbtr" = {
        isSystemUser = true;
	      group = "qbtr";
	      extraGroups = [ "users" ];
      };
    };
  };
}
