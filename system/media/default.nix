{
  config,
  pkgs,
  ...
}: {
  systemd.mounts = [
    {
      description = "Media Disk Mount";
      type = "ntfs";
      where = "/var/media";
      what = "/dev/disk/by-uuid/4FC36CA13FB6EC1F";
      mountConfig = {
        Options = "umask=007,uid=margartv,gid=media,x-systemd.idle-timeout=30s";
      };
    }
    {
      description = "TrueNAS Media Server Mount";
      type = "cifs";
      where = "/mnt/media";
      what = "//192.168.3.10/mnt";
      mountConfig = {
        Options = "credentials=/run/secrets/smb/credentials,x-systemd.automount,noauto,uid=1001,gid=1002";
      };
    }
  ];

  systemd.automounts = [
    {
      description = "Media Disk Automount";
      wantedBy = ["multi-user.target"];
      where = "/var/media";
    }
    {
      description = "TrueNAS Media Server Automount";
      wantedBy = ["multi-user.target"];
      where = "/mnt/media";
    }
  ];
}
