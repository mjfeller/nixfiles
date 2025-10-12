{
  config,
  pkgs,
  ...
}: {
  home.file = {
    # zsh configuration
    ".zshenv".source = ./files/.zshenv;
    ".config/zsh/.zshenv".source = ./files/.config/zsh/.zshenv;
    ".config/zsh/.zshrc".source = ./files/.config/zsh/.zshrc;
    ".config/zsh/aliasrc".source = ./files/.config/zsh/aliasrc;
    ".config/zsh/fzf.zsh".source = ./files/.config/zsh/fzf.zsh;
    ".config/zsh/kubernetes.zsh".source = ./files/.config/zsh/kubernetes.zsh;
  };

  # Zsh is a shell designed for interactive use, although it is also a
  # powerful scripting language. More information can be found on the
  # "Zsh Web Pages" sites.
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history.size = 10000;
    history.path = "${config.xdg.cacheHome}/zsh/history";
  };
}
