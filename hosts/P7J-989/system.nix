{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system/emacs
    ../../system/fonts
    ../../system/macos
    ../../system/prelude
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mjf = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      ../../home/bin
      ../../home/git
      ../../home/lf
      ../../home/xdg
      ../../home/zsh
    ];

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "22.11";

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "mjf";
    home.homeDirectory = "/Users/mjf";
    home.packages = with pkgs; [];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

  system.primaryUser = "mjf";
  ids.gids.nixbld = 350;

  # Setup primary user
  users.users.mjf = {
    name = "mjf";
    home = "/Users/mjf";
  };

  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.trusted-users = ["root" "mjf"];

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    comma
    direnv
    go
    ispell
    jujutsu
    ledger
    mediainfo
    mpv
    nix-index
    shellcheck
    zig
    zls

    brave
    signal-desktop-bin
    spotify
    whatsapp-for-mac
    yubikey-manager
  ];

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;

  networking.computerName = "P7J-989";
  networking.localHostName = "P7J-989";
  networking.hostName = "P7J-989";

  networking.dns = [
    "192.168.2.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  networking.knownNetworkServices = [
    "Wi-Fi"
    "Ethernet Adaptor"
    "Thunderbolt Ethernet"
  ];
}
