{
  config,
  pkgs,
  ...
}: {
  home.file = {
    # lf configuration
    ".config/lf".source = ./files;
    ".config/lf".recursive = true;
  };

  # lf (as in "list files") is a terminal file manager written in Go
  # with a heavy inspiration from ranger file manager.
  programs.lf.enable = true;
}
