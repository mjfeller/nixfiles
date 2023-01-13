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

    ./media
    ./networking
    ./secrets
    ./x11
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

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Services

  # Monero server for syncing the blockchain
  # services.monero.enable = true;

  # Enable sound.
  sound.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Users

  # Define a user account. Don't forget to set a password with passwd
  users.users.mjf = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "media"]; # Enable sudo for the user.
  };

  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #  Packages

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    bat
    cmake
    dig
    direnv
    emacs28Packages.vterm
    emacsUnstable
    file
    fzf
    gcc
    git
    gnumake
    htop
    inetutils
    ipfs
    libtool
    libvterm
    lsof
    mediainfo
    netcat
    nmap
    offlineimap
    pinentry
    pinentry-qt
    pipewire
    prismlauncher # Minecraft Launcher
    psmisc # provides killall
    pulsemixer
    ripgrep
    sops
    transmission-remote-gtk
    unzip
    wget
    wireguard-tools
    xdg-utils
    zip
  ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DOWNLOADS_DIR = "$HOME/downloads";
    XDG_DOCUMENTS_DIR = "$HOME/documents";
    XDG_CODE_DIR = "$HOME/development";

    EDITOR = "emacs";
    VISIAL = "less";
    # GNUPGHOME = "$XDG_DATA_HOME/gnupg";
  };

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
