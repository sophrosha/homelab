{ ... }: {
  services.fail2ban = {
    enable = true;
    maxretry = 10;
    ignoreIP = [ "127.0.0.1/8" "192.168.0.0/24" "::1" ];
    jails = {
      sshd.settings = {
        enabled = true;
	      maxretry = 5;
	      findtime = "10m";
	      bantime = "1h";
      };
      recidive.settings = {
        enabled = true;
	      maxretry = 2;
	      findtime = "1d";
	      bantime = "30d";
      };
    };
  };
}
