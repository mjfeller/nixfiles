{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    fd
    file
    fzf
    git
    htop
    jq
    lsof
    ripgrep
    unzip
    wget
    zip
  ];
}
