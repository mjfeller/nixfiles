{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Mark Feller";
        email = "mark@mfeller.io";
      };

      url."git@github.com:".insteadOf = "https://github.com/";
    };

    signing.key = "76AABB34AAFE630A6F571F6B3A6412B0CE2F05A8";
    signing.signByDefault = false;
  };
}
