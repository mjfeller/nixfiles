{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../system/networking/wireguard.nix
    ../../system/media/downloaders.nix
    ../../system/media/mounts.nix
    ../../system/users
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    dig
    htop
    inetutils
    lsof
    netcat
    nmap
    wget
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  programs.zsh.enable = true;

  # Open ports in the firewall.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # networking.hostName = "P3R-272";
  networking.hostName = "dl";
  networking.domain = "margar.org";
  networking.nameservers = ["192.168.1.1" "8.8.8.8" "8.8.4.4"];
  networking.networkmanager.enable = true;
}
