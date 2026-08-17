{ ... }: {
  networking = {
    hosts = {
      "192.168.0.1" = [ "network.router.local" ];
      "192.168.1.1" = [ "wifi.router.local" ];
      "192.168.0.100" = [ "pc.local" ];
      "192.168.0.102" = [ 
        "server.local" "pihole.server.local" "grafana.server.local" 
	      "syncthing.server.local" "kino.server.local" "smb.server.local"
	      "torr.server.local" "qtorr.server.local"
	      "stories.server.local" "panel.stories.server.local"
	      "proxy.server.local"
      ];
    };
  };

  services = {
    pihole-ftl = {
      enable = true;
      lists = [
        {
          url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
          type = "block";
          enabled = true;
          description = "Steven Black's HOSTS";
        }
      ];
      openFirewallDNS = true;
      openFirewallDHCP = true;
      openFirewallWebserver = false;
      queryLogDeleter = {
        enable = true;
	      age = 50;
	      interval = "weekly";
      };
      settings = {
        misc.readOnly = true;
        dns = {
          domain = "server.local";
          domainNeeded = true;
          expandHosts = true;
          interface = "enp2s0";
          upstreams = ["8.8.8.8" "8.8.4.4"];
        };
        webserver = {
          api = {
	          localAPIauth = false;
	          pwhash = "";
          };
          session = {
            timeout = 43200; 
          };
        };
      };
      useDnsmasqConfig = true;
    };

    pihole-web = {
      enable = true;
      ports = [9832];
    };

    resolved = {
      settings = {
        Resolve = {
          DNSStubListener = false;
          MulticastDNS = false;
        };
      };
    };

    nginx.virtualHosts."pihole.server.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:9832";
	      extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";
	      '';
      };
    };
  };

  systemd.tmpfiles.rules = [
    "f /etc/pihole/versions 0644 pihole pihole - -"
  ];
}
