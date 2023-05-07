{
  config,
  pkgs,
  ...
}: {
  programs.zathura.enable = true;

  home.file = {
    ".config/zathura".source = ./files;
    ".config/zathura".recursive = true;
  };
}
