{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system/fonts
    ../../system/emacs
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
      ../../home/alacritty
      ../../home/bin
      ../../home/git
      ../../home/lf
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

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "mjf"];
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.package = pkgs.nix;

  # Setup primary user
  users.users.mjf = {
    name = "mjf";
    home = "/Users/mjf";
  };

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    direnv
    ispell
    mediainfo
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;

  fonts.fontDir.enable = true;
}
