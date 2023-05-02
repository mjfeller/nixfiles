{ config, pkgs, ... }: {
  home.file = {
    # shell scripts
    ".local/bin/pash".source = ../dots/.local/bin/pash;
    ".local/bin/pash_check".source = ../dots/.local/bin/pash_check;
    ".local/bin/pash_check_all".source = ../dots/.local/bin/pash_check_all;
    ".local/bin/pash_sync".source = ../dots/.local/bin/pash_sync;
  };
}
