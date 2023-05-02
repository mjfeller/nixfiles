{ config, pkgs, ... }: {
  home.file = {
    # shell scripts
    ".local/bin".source = ./files;
    ".local/bin".recursive = true;
  };
}
