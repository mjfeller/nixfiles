{ config, pkgs, ... }: {
  home.file = {
    ".config/git/config".source = ./files/config.work;
  };
}
