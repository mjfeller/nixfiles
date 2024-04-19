{
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    curl
    dig
    fd
    file
    fzf
    git
    htop
    inetutils
    jq
    lf
    lsof
    netcat
    ripgrep
    rsync
    tree
    unzip
    watch
    wget
    zip
  ];
}
