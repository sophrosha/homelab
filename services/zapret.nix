{ ... }: {
  networking.nftables.enable = false;
  services.zapret-discord-youtube = {
    enable = true;
    configName = "general(ALT)";
    gameFilter = "null";
  };
}
