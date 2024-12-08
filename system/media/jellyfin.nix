{
  config,
  pkgs,
  ...
}: {
  # Jellyfin is a Free Software Media System that puts you in control of
  # managing and streaming your media.
  services.jellyfin.enable = true;
  services.jellyfin.group = "margartv";

  # Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS
  # feeds for your favorite shows and will grab, sort and rename them.
  services.sonarr.enable = true;
  services.sonarr.group = "margartv";

  # Radarr is a movie collection manager for Usenet and BitTorrent users. It can
  # monitor multiple RSS feeds for new movies and will interface with clients
  # and indexers to grab, sort, and rename them.
  services.radarr.enable = true;
  services.radarr.group = "margartv";

  # Lidarr is a music collection manager for Usenet and BitTorrent users. It can
  # monitor multiple RSS feeds for new albums from your favorite artists and
  # will interface with clients and indexers to grab, sort, and rename them.
  services.lidarr.enable = true;
  services.lidarr.group = "margartv";

  # API Support for your favorite torrent trackers.
  services.jackett.enable = true;
  services.jackett.group = "margartv";

  # Indexer manager/proxy built on the popular arr .net/reactjs base stack.
  services.prowlarr.enable = true;

  # ----------------------------------------------------------------------
  #  Site

  environment.systemPackages = with pkgs; [
    certigo
  ];

  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;

  # Setup an nginx proxy virtual hosts for margar.tv with TLS certificates
  # managed by certbot.
  services.nginx.virtualHosts = {
    "www.margar.tv" = {
      forceSSL = true;
      sslCertificate = "/var/lib/acme/www.margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/www.margar.tv/key.pem";

      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
      };
      locations."/radarr" = {
        proxyPass = "http://localhost:7878/radarr";
      };
      locations."/sonarr" = {
        proxyPass = "http://localhost:8989/sonarr";
      };
      locations."/lidarr" = {
        proxyPass = "http://localhost:8686/lidarr";
      };
      locations."/prowlarr" = {
        proxyPass = "http://localhost:9696/prowlarr";
      };
      locations."/jackett" = {
        proxyPass = "http://localhost:9117/jackett";
      };
      locations."/nzbget" = {
        proxyPass = "http://192.168.3.201:6789/nzbget";
      };
    };

    "margar.tv" = {
      forceSSL = true;
      globalRedirect = "www.margar.tv";
      sslCertificate = "/var/lib/acme/www.margar.tv/cert.pem";
      sslCertificateKey = "/var/lib/acme/www.margar.tv/key.pem";
    };
  };

  # nginx must be in the acme group in order to access certificates
  users.users.nginx.extraGroups = ["acme"];

  # Setup DNS01 acme challenges with letsencypt and Google Cloud DNS to
  # generate TLS certificates.
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "mjfeller1992@gmail.com";
  security.acme.certs."www.margar.tv" = {
    domain = "www.margar.tv";
    dnsProvider = "gcloud";
    credentialsFile = "/etc/secrets/certs.secret";
    extraDomainNames = ["www.margar.tv" "margar.tv"];
  };

  # Setup the credentials file used by certbot to manage TLS certificates.
  environment.etc."secrets/certs.secret".text = ''
    GCE_PROJECT=digital-ocean-265322
    GCE_SERVICE_ACCOUNT_FILE=/etc/gcp.json
  '';
}
