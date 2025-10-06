{
  config,
  pkgs,
  ...
}: {
  config.xdg.cacheHome = "${config.home.homeDirectory}/.cache";
  config.xdg.configHome = "${config.home.homeDirectory}/.config";
  config.xdg.dataHome = "${config.home.homeDirectory}/.local";

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
