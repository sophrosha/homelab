{ config, ... }: {
  sops.secrets."grafana_secret" = {
    owner = "grafana";
    group = "grafana";
    mode = "0400";
  };
  services = {
    grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "0.0.0.0";
          http_port = 3432;
          enforce_domain = true;
          enable_gzip = true;
          domain = "grafana.server.local";
        };
        security.secret_key = "$__file{${config.sops.secrets.grafana_secret.path}}"; 
      }; 
    };
    prometheus = {
      enable = true;
      enableReload = true;
      port = 9099;
      scrapeConfigs = [
       { 
         job_name = "node";
	 static_configs = [{ targets = [ "127.0.0.1:9000" ]; }];
       }
      ];
      exporters = {
        node = {
          enable = true;
	  port = 9000;
	  enabledCollectors = [
            "cpu" "loadavg" "meminfo" "diskstats" "netdev"
	    "filesystem" "systemd" "swap" "hwmon" "ntp" "os"
	    "netstat" "vmstat"
	  ];
	};
	#snmp = {}; потом до роутеров дойду
      };
    };
    nginx.virtualHosts."grafana.server.local" = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:3432";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
  };
}
