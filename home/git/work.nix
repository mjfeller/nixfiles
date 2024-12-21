{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Mark Feller";
    userEmail = "mark@block.xyz";
    signing.key = "AD1123AE40116CBA25464FA10B54905CC58C10EE";
    signing.signByDefault = false;

    extraConfig = {
      github.user = "mfeller-square";
    };

    includes = [
      {
        path = "$SQUARE_HOME/config_files/square/gitconfig";
      }
    ];
  };
}
