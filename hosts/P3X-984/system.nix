{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../system/macos
  ];

  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";

  # Setup primary user
  users.users.mjf = {
    name = "mjf";
    home = "/Users/mjf";
  };

  # List of installed packages specific to this host.
  environment.systemPackages = with pkgs; [
    bazel_6
    cargo
    cmake
    go
    home-manager
    notmuch
    rust-analyzer
    rustc
    rustfmt
    transmission
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # ZSH Basic Configuration
  programs.zsh.enable = true;

  # GPG Configuration
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  programs.man.enable = true;
}
