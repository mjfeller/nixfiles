{
  config,
  pkgs,
  ...
}: {
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

  # This is the actual specification of the secrets.
  sops.secrets."wireguard/privatekey" = {};
  sops.secrets."wireguard/presharedkey" = {};
  sops.secrets."tailscale/authkey" = {};
}
