{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "mjf";
  networking.wg-quick.interfaces = {
    cs0 = {
      address = ["10.10.6.71"];
      dns = ["10.31.33.8"];
      privateKeyFile = "/run/secrets/wireguard/privatekey";
      peers = [
        {
          publicKey = "Au/fpRa/6gXHsi1ek0f5ro59EbTXS3orn/wiLa5L1UM=";
          presharedKeyFile = "/run/secrets/wireguard/presharedkey";
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "iceland.cstorm.is:443";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
