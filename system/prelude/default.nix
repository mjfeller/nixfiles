{
  config,
  pkgs,
  ...
}: {
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
