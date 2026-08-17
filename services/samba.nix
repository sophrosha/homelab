{ ... }: {
  services = { 
    samba = {
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smb.server.local";
          "netbios name" = "homelab";
          "security" = "user";
          "hosts allow" = "192.168.0. 192.168.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "public" = {
          "path" = "/home/server/disk/public";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "create mask" = "0660";
          "directory mask" = "0770";
	  "force user" = "server";
          "force group" = "users";
        };
        "private" = {
          "path" = "/home/server/disk/private";
          "browseable" = "no";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "server";
          "force group" = "users";
	  "valid users" = "sophrosha";
        };
      };
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
      hostname = "homelab";
      workgroup = "WORKGROUP";
    };
  };

  users = {
    groups."smb" = {};
    users = { 
      "sophrosha" = {
        isSystemUser = true;
        group = "smb";
	extraGroups = [ "users" ];
      };
      "user" = {
        isSystemUser = true;
	group = "smb";
	extraGroups = [ "users" ];
      };
    };
  };
}
