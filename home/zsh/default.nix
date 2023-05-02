{
  config,
  pkgs,
  ...
}: {
  home.file = {
    # zsh configuration
    ".zshenv".source = ../dots/.zshenv;
    ".config/zsh/.zshenv".source = ../dots/.config/zsh/.zshenv;
    ".config/zsh/.zshrc".source = ../dots/.config/zsh/.zshrc;
    ".config/zsh/aliasrc".source = ../dots/.config/zsh/aliasrc;
    ".config/zsh/fzf.zsh".source = ../dots/.config/zsh/fzf.zsh;
    ".config/zsh/gcloud.zsh".source = ../dots/.config/zsh/gcloud.zsh;
    ".config/zsh/kubernetes.zsh".source = ../dots/.config/zsh/kubernetes.zsh;
  };

  # Zsh is a shell designed for interactive use, although it is also a
  # powerful scripting language. More information can be found on the
  # "Zsh Web Pages" sites.
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history.size = 10000;
    history.path = "${config.xdg.cacheHome}/zsh/history";
  };
}
