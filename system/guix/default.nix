{
  config,
  pkgs,
  ...
}: {
  systemd.mounts = [
    {
      description = "Read-only /gnu/store for GNU Guix";
      # defaultDependencies = "no";
      # conditionPathExists = "/gnu/store";
      before = ["guix-daemon.service"];
      type = "none";
      where = "/gnu/store";
      what = "/gnu/store";
      mountConfig = {
        Options = "bind,ro";
      };
    }
  ];

  systemd.services.guix-daemon = {
    description = "Build daemon for GNU Guix";
    serviceConfig = {
      ExecStart = "/var/guix/profiles/per-user/root/current-guix/bin/guix-daemon --build-users-group=guixbuild --discover=no";
      Environment = "'GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale' LC_ALL=en_US.utf8";
      StandardOutput = "syslog";
      StandardError = "syslog";
      OOMPolicy = "continue";
      Restart = "always";
      TasksMax = "8192";
    };
    wantedBy = ["multi-user.target"];
  };

  systemd.services.guix-gc = {
    description = "Discard unused Guix store items";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/var/guix/profiles/per-user/root/current-guix/bin/guix gc -d 1m -F 10G";
      PrivateDevices = "yes";
      PrivateNetwork = "yes";
      PrivateUsers = "no";
      ProtectKernelTunables = "yes";
      ProtectKernelModules = "yes";
      ProtectControlGroups = "yes";
      MemoryDenyWriteExecute = "yes";
      SystemCallFilter = "@default @file-system @basic-io @system-service";
    };
  };

  systemd.services.guix-publish = {
    description = "Publish the GNU Guix store";
    requires = ["guix-daemon.service"];
    partOf = ["guix-daemon.service"];
    after = ["guix-daemon.service"];
    serviceConfig = {
      ExecStart = "/var/guix/profiles/per-user/root/current-guix/bin/guix publish --user=nobody --port=8181";
      Environment = "'GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale' LC_ALL=en_US.utf8";
      StandardOutput = "syslog";
      StandardError = "syslog";
      Restart = "always";
      TasksMax = "1024";
    };
    wantedBy = ["multi-user.target"];
  };
}
