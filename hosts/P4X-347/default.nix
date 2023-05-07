{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../system/media/jellyfin.nix
    ../../system/media/mounts.nix
    ../../system/users
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "P4X-347";
  networking.domain = "margar.org";
  networking.networkmanager.enable = true;
}