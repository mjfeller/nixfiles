{
  config,
  pkgs,
  ...
}: {
  home.file = {
    ".local/share/emacs".source = ./files;
    ".local/share/emacs".recursive = true;
  };
}
