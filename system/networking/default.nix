{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./tailscale.nix
    ./wireguard.nix
  ];

  networking.hostName = "mjf";
  networking.nameservers = ["8.8.8.8" "8.8.4.4"];

  networking.firewall = {
    enable = false;
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
    allowedTCPPorts = [22 80 443];
  };
}
