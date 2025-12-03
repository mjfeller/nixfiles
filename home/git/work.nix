{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    signing.key = "AD1123AE40116CBA25464FA10B54905CC58C10EE";
    signing.signByDefault = false;

    settings = {
      user.name = "Mark Feller";
      user.email = "mark@block.xyz";
      github.user = "mfeller-square";
    };

    includes = [
      {
        path = "$SQUARE_HOME/config_files/square/gitconfig";
      }
    ];
  };
}
