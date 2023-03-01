{
  config,
  pkgs,
  ...
}: {
  imports = [
    # ./wireguard.nix
  ];

  networking.hostName = "mjf";
  networking.domain = "margar.org";
  networking.nameservers = ["192.168.1.1" "8.8.8.8" "8.8.4.4"];
}
