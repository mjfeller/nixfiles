{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system/macos
  ];

  # Setup primary user
  users.users.mjf = {
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

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;
}
