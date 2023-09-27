{
  config,
  pkgs,
  ...
}: {
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };
}
