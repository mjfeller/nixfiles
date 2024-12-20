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
  home-manager.users.mfeller = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      ../../home/alacritty
      ../../home/bin
      ../../home/git/work.nix
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
    home.username = "mfeller";
    home.homeDirectory = "/Users/mfeller";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };

  # Setup primary user
  users.users.mfeller = {
    name = "mfeller";
    home = "/Users/mfeller";
  };

  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.trusted-users = ["root" "mfeller"];
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    cargo
    cmake
    crudini
    cue
    direnv
    eksctl
    go
    ispell
    jujutsu
    mediainfo
    rust-analyzer
    rustc
    rustfmt
    shellcheck
    zig
    zls

    upbound
    mockgen
  ];

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;
}
