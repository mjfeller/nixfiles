{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../system/audio
    ../../system/emacs
    ../../system/fonts
    ../../system/media
    ../../system/networking
    ../../system/networking/tailscale.nix
    ../../system/nix
    ../../system/prelude
    ../../system/secrets
    ../../system/users
    ../../system/wayland
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mjf = {
    imports = [
      ../../home/alacritty
      ../../home/bin
      ../../home/dunst
      ../../home/git
      ../../home/gpg
      ../../home/lf
      ../../home/mail
      ../../home/media
      ../../home/xdg
      ../../home/zathura
      ../../home/zsh
    ];

    home.username = "mjf";
    home.homeDirectory = "/home/mjf";
    home.stateVersion = "22.11";

    services.mpd.enable = true;
    services.mpd.musicDirectory = "/var/media/music";

    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      brave
      spotify
      whatsapp-for-linux
    ];

    programs.man.enable = true;
    programs.man.generateCaches = true;
  };

  # Set your timezone
  time.timeZone = "America/Denver";

  # Auto generate mandb caches so we can use apropos and man -k
  documentation.dev.enable = true;
  documentation.man.enable = true;
  documentation.man.man-db.enable = true;
  documentation.man.generateCaches = true;

  security.polkit.enable = true;

  networking.hostName = "P2X-3YZ";
  networking.domain = "margar.org";
  networking.networkmanager.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Services

  # Monero server for syncing the blockchain
  services.monero.enable = true;
  services.monero.dataDir = "/var/lib/monero";

  services.udev.packages = [pkgs.yubikey-personalization];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    graphviz
    ledger
    monero-gui
    pinentry
    pinentry-qt
    sxiv
  ];

  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";
}
