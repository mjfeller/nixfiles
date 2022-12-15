{
  config,
  pkgs,
  ...
}: {
  # User and Group for media mount and system services that need access to said
  # media.
  users.users.margartv.isSystemUser = true;
  users.users.margartv.group = "media";
  users.groups.media = {};

  # ----------------------------------------------------------------------
  #  Services

  # Ombi is your friendly media request tool, automatically syncs with your
  # media servers
  services.ombi.enable = true;
  services.ombi.group = "media";

  # Jellyfin is a Free Software Media System that puts you in control of
  # managing and streaming your media.
  services.jellyfin.enable = true;
  services.jellyfin.group = "media";

  # Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS
  # feeds for new episodes of your favorite shows and will grab, sort and rename
  # them.
  services.sonarr.enable = true;
  services.sonarr.group = "media";

  # Radarr is a movie collection manager for Usenet and BitTorrent users. It can
  # monitor multiple RSS feeds for new movies and will interface with clients
  # and indexers to grab, sort, and rename them.
  services.radarr.enable = true;
  services.radarr.group = "media";

  # Lidarr is a music collection manager for Usenet and BitTorrent
  # users. It can monitor multiple RSS feeds for new albums from your
  # favorite artists and will interface with clients and indexers to
  # grab, sort, and rename them.
  services.lidarr.enable = true;
  services.lidarr.group = "users";

  # services.readarr.enable = true;
  # services.readarr.group = "media";

  # NZBGet is a binary downloader, which downloads files from Usenet based on
  # information given in nzb-files.
  services.nzbget.enable = true;
  services.nzbget.group = "media";

  # ----------------------------------------------------------------------
  #  Site

  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;

  # Setup an nginx proxy virtual hosts for both Ombi and Jellyfin for margar.tv
  # with TLS certificates managed by certbot.
  services.nginx.virtualHosts = {
    "margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:5000";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
    "watch.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
    "sonarr.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:8989";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
    "radarr.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:7878";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
    "lidarr.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:8686";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
    "nzbget.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/margar.tv/key.pem";
      locations."/" = {
        proxyPass = "http://127.0.0.1:6789";
        proxyWebsockets = true;
        extraConfig =
          "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
    };
  };

  # ----------------------------------------------------------------------
  #  TLS Certificate Management

  # nginx must be in the acme group in order to access certificates
  users.users.nginx.extraGroups = ["acme"];

  # Setup DNS01 acme challenges with letsencypt and Google Cloud DNS to
  # generate TLS certificates.
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "mjfeller1992@gmail.com";
  security.acme.certs."margar.tv" = {
    domain = "margar.tv";
    dnsProvider = "gcloud";
    credentialsFile = "/etc/secrets/certs.secret";
    extraDomainNames = ["*.margar.tv"];
  };

  # Setup the credentials file used by certbot to manage TLS certificates.
  environment.etc."secrets/certs.secret".text = ''
    GCE_PROJECT=digital-ocean-265322
    GCE_SERVICE_ACCOUNT_FILE=/run/secrets/gcp/service-account-credentials.json
  '';

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
}
