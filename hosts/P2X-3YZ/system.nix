{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../system/audio
    ../../system/emacs
    ../../system/media
    ../../system/networking
    ../../system/networking/tailscale.nix
    ../../system/nix
    ../../system/secrets
    ../../system/users
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mjf = {
    imports = [
      ../../home/alacritty
      ../../home/bin
      ../../home/dunst
      ../../home/emacs
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

  # services.pcscd.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    file
    fzf
    git
    graphviz
    htop
    lsof
    monero-gui
    pinentry
    pinentry-qt
    ripgrep
    sxiv
    unzip
    zip
    bemenu
    jq
    ledger
    xdg-utils
    wl-clipboard
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam.enable = true;

  fonts.packages = with pkgs; [
    comic-mono
    iosevka
    iosevka-comfy.comfy
    iosevka-comfy.comfy-duo
    iosevka-comfy.comfy-wide
    iosevka-comfy.comfy-fixed
    iosevka-comfy.comfy-motion
    iosevka-comfy.comfy-wide-duo
    iosevka-comfy.comfy-wide-fixed
    iosevka-comfy.comfy-motion-duo
    iosevka-comfy.comfy-motion-fixed
    iosevka-comfy.comfy-wide-motion
    iosevka-comfy.comfy-wide-motion-duo
    iosevka-comfy.comfy-wide-motion-fixed
  ];

  programs.zsh.enable = true;
  programs.river.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11";

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
}
