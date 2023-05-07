{
  config,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ../../home/alacritty
    ../../home/bin
    ../../home/dunst
    ../../home/emacs
    ../../home/git
    ../../home/gpg
    ../../home/lf
    ../../home/mail
    ../../home/sx
    ../../home/media
    ../../home/xdg
    ../../home/zathura
    ../../home/zsh
  ];

  home.username = "mjf";
  home.homeDirectory = "/home/mjf";
  home.stateVersion = "22.11";

  services.mpd.enable = true;
  services.mpd.musicDirectory = "/var/media/music";

  home.packages = with pkgs; [
    brave
    monero-gui
  ];
}
