{ config, pkgs, ... }: {
  home.file = {
    ".config/git/config".source = ../dots/.config/git/config.work;
  };
}
