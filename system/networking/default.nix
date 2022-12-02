{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "mjf";
  networking.nameservers = ["8.8.8.8" "8.8.4.4"];

  networking.firewall = {
    enable = false;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
    allowedTCPPorts = [22 80 443];
  };

  # ----------------------------------------------------------------------
  #  Wireguard

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

  # ----------------------------------------------------------------------
  #  Tailscale

  # Tailscale lets you easily manage access to private resources, quickly SSH
  # into devices on your network, and work securely from anywhere in the world.
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [tailscale jq];

  # create a oneshot job to authenticate to Tailscale
  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";
    after = ["network-pre.target" "tailscale.service"];
    wants = ["network-pre.target" "tailscale.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "oneshot";
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up -authkey $(cat /run/secrets/tailscale/authkey)
    '';
  };
}
