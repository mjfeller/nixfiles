{
  config,
  pkgs,
  ...
}: {
  };

  # ----------------------------------------------------------------------
  #  Media Mount

  # Use systemd mount and automount units to automatically mount my
  # external drive to my home directory when necessary.
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
  ];
  systemd.automounts = [
    {
      description = "Media Disk Automount";
      wantedBy = ["multi-user.target"];
      where = "/var/media";
    }
  ];

  networking.extraHosts = ''
    192.168.3.200 margar.tv
    192.168.3.200 www.margar.tv
    192.168.3.200 search.margar.tv
  '';
}
