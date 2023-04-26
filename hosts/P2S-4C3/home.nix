{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home
    ../../home/git/work.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mfeller";
  home.homeDirectory = "/home/mfeller";
}
