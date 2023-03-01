{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [samba cifs-utils];

  systemd.mounts = [
    {
      description = "TrueNAS Media Server Mount";
      type = "cifs";
      where = "/var/media";
      what = "//nas.margar.org/mnt";
      mountConfig = {
        Options = "credentials=/run/secrets/smb/credentials,x-systemd.automount,noauto,uid=1001,gid=1002";
      };
    }
  ];

  systemd.automounts = [
    {
      description = "TrueNAS Media Server Automount";
      wantedBy = ["multi-user.target"];
      where = "/var/media";
    }
  ];
}
