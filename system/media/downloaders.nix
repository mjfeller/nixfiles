{
  config,
  pkgs,
  ...
}: {
  # NZBGet is a binary downloader, which downloads files from Usenet based on
  # information given in nzb-files.
  services.nzbget.enable = true;
  services.nzbget.user = "margartv";
  services.nzbget.group = "margartv";

  services.transmission.enable = true;
  services.transmission.user = "margartv";
  services.transmission.group = "margartv";
  services.transmission.settings = {
    rpc-bind-address = "0.0.0.0";
    rpc-whitelist = "*.*.*.*";
    download-dir = "/var/media/downloads";
    incomplete-dir = "/var/media/downloads/.incomplete";
    incomplete-dir-enabled = true;
  };
}
