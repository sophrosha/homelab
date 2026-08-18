{ ... }: {
  systemd.tmpfiles.rules = [
    "z /home/server 0750 server users - -"
    "z /home/server/disk 0750 server users - -"
    "z /home/server/nixosConfigs 0740 server users - -"
    "z /home/server/disk/public 0775 server users - -"
    "z /home/server/disk/private 0770 server users - -" 

    "a /home/server/nixosConfigs - - - - g:deploy:rx"
  ];  
}
