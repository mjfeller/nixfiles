{
  config,
  pkgs,
  ...
}: {
  # Brother MFC-7360N scanner and printer
  services.printing.enable = true;
  services.printing.drivers = [pkgs.brlaser];
  services.avahi.enable = true;
  services.avahi.nssmdns = false;
  hardware.sane.enable = true;
  hardware.sane.brscan4.enable = true;
  hardware.sane.brscan4.netDevices = {
    home = {
      model = "MFC-7360N";
      ip = "192.168.1.10";
    };
  };
  system.nssModules = with pkgs.lib; optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  system.nssDatabases.hosts = with pkgs.lib;
    optionals (!config.services.avahi.nssmdns) (mkMerge [
      (mkOrder 900 ["mdns4_minimal [NOTFOUND=return]"]) # must be before resolve
      (mkOrder 1501 ["mdns4"]) # 1501 to ensure it's after dns
    ]);

  environment.systemPackages = with pkgs; [
    simple-scan
  ];
}
