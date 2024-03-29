{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Mark Feller";
    userEmail = "mark@mfeller.io";
    signing.key = "76AABB34AAFE630A6F571F6B3A6412B0CE2F05A8";
    signing.signByDefault = false;
  };
}
