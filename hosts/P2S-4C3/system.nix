{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system/emacs
    ../../system/macos
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.mfeller = {config, pkgs, ...}: {
    imports = [
      ../../home/alacritty
      ../../home/bin
      ../../home/emacs
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
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.package = pkgs.nix;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    bazel_6
    cargo
    cmake
    curl
    dig
    direnv
    fd
    file
    fzf
    git
    go
    home-manager
    htop
    inetutils
    ispell
    jq
    lf
    mediainfo
    ripgrep
    rust-analyzer
    rustc
    rustfmt
    shellcheck
    tree
    watch
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
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

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;
}
