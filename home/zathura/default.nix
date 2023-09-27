{
  config,
  pkgs,
  ...
}: {
  programs.zathura = {
    enable = true;
    mappings = {
      "<C-i>" = "recolor";
    };
  };
}
