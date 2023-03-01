{
  config,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mjf = {
    isNormalUser = true;
    description = "mjf";
    extraGroups = ["networkmanager" "wheel" "margartv"];
    packages = with pkgs; [];
    uid = 1000;
    shell = pkgs.zsh;
  };

  # User and Group for media mount and system services that need access to said
  # media.
  users.users.margartv = {
    isSystemUser = true;
    group = "margartv";
    uid = 1001;
  };

  # Groups
  users.groups.margartv = {gid = 1002;};
}
