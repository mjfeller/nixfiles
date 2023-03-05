{
  config,
  pkgs,
  ...
}: {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./alacritty
    ./dunst
    ./lf
    ./mail
    ./sx
    ./media
    ./zsh
  ];

  home.username = "mjf";
  home.homeDirectory = "/home/mjf";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    brave
    monero-gui
    sxiv
    zathura
  ];
}
