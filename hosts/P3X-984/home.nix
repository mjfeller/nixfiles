{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home
    ../../home/git
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mjf";
  home.homeDirectory = "/home/mjf";
}
