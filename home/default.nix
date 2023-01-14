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
    ./sxhkd
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

  # xdg mime types allows default applications to be used to open files
  # of a specific type. The file type of an application can be
  # determined using the mimetype utility.
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "application/postscript" = "org.pwmt.zathura-pdf-mupdf.desktop";
    "image/png" = "sxiv.desktop";
    "image/jpeg" = "sxiv.desktop";
    "image/gif" = "sxiv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "inode/directory" = "lf.desktop";
  };
}
