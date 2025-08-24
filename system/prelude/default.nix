{
  config,
  pkgs,
  ...
}: {
  # nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.package = pkgs.nix;

  environment.systemPackages = with pkgs; [
    curl
    dig
    fd
    file
    fzf
    git
    gnupg
    htop
    inetutils
    jq
    lf
    lsof
    netcat
    openssh
    ripgrep
    rsync
    tree
    unzip
    vim
    watch
    wget
    zip
  ];
}
