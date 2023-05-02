{ config, pkgs, ... }: {
  home.file = {
    ".local/share/emacs".source = ../dots/.local/share/emacs;
  };
}
