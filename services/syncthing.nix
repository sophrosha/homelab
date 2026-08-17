{ ... }: {
  services.syncthing = {
    enable = true;
    user = "server";
    group = "users";
    dataDir = "/home/server";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    overrideDevices = false;
    overrideFolders = false;
  };
}
