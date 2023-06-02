# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../../system/media
    ../../system/networking
    ../../system/secrets
    ../../system/x11
    ../../system/users
  ];

  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs"];

  # Set your timezone
  time.timeZone = "America/Denver";

  # Auto generate mandb caches so we can use apropos and man -k
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

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.udev.packages = [pkgs.yubikey-personalization];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.openssh.passwordAuthentication = false;
  services.openssh.kbdInteractiveAuthentication = false;

  # services.pcscd.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    bat
    file
    fzf
    git
    graphviz
    htop
    imv
    ledger
    lf
    lsof
    mpd
    mpv
    ncmpcpp
    netcat
    nmap
    notmuch
    offlineimap
    pulsemixer
    ripgrep
    sx
    sxiv
    unzip
    xclip
    zathura
    zip
    zsh

    direnv
    pinentry
    pinentry-qt
    pipewire
    sops
    wget

    bazel_6
    bazelisk
    transmission-remote-gtk

    ((emacsPackagesFor emacs-unstable).emacsWithPackages (epkgs: [
      epkgs.bind-key
      epkgs.company
      epkgs.company-c-headers
      epkgs.comment-dwim-2
      epkgs.consult
      epkgs.csv-mode
      epkgs.direnv
      epkgs.dockerfile-mode
      epkgs.elfeed
      epkgs.embark
      epkgs.embark-consult
      epkgs.evil
      epkgs.evil-goggles
      epkgs.evil-surround
      epkgs.ggtags
      epkgs.git-timemachine
      epkgs.go-mode
      epkgs.helpful
      epkgs.highlight-indentation
      epkgs.ledger-mode
      epkgs.logos
      epkgs.macrostep
      epkgs.magit
      epkgs.minions
      epkgs.modus-themes
      epkgs.multi-vterm
      epkgs.multiple-cursors
      epkgs.nix-mode
      epkgs.notmuch
      epkgs.olivetti
      epkgs.orderless
      epkgs.org-bullets
      epkgs.org-fancy-priorities
      epkgs.paren-face
      epkgs.racer
      epkgs.restclient
      epkgs.rg
      epkgs.rust-mode
      epkgs.tree-sitter
      epkgs.tree-sitter-langs
      epkgs.use-package
      epkgs.vertico
      epkgs.vterm
      epkgs.yaml-mode
      epkgs.yasnippet
    ]))
  ];

  fonts.fonts = [pkgs.comic-mono];

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = ["git"];
      theme = "eastwood";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "qt";
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
}
