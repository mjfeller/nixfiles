{
  config,
  pkgs,
  ...
}: {
  # Add in the experimental nix command line tool and flakes. The nix
  # command 'should' be in the next release of nixos. As for when flakes
  # become mainlined who knows.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # List of packages to be installed on every system I use.
  environment.systemPackages = with pkgs; [
    curl
    dig
    direnv
    fd
    file
    fzf
    git
    home-manager
    htop
    inetutils
    ispell
    jq
    lf
    mediainfo
    ripgrep
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
